// ==UserScript==
// @name           Text Lightener
// @description    Converts dark text to light while preserving light colors
// @include        main
// ==/UserScript==

(function() {
    // Function to calculate luminosity of an RGB color
    function getLuminosity(r, g, b) {
        const [rs, gs, bs] = [r, g, b].map(c => {
            c = c / 255;
            return c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4);
        });
        return 0.2126 * rs + 0.7152 * gs + 0.0722 * bs;
    }

    // Function to parse color string to RGB values
    function parseColor(colorString) {
        const rgbMatch = colorString.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)/);
        if (rgbMatch) {
            return [parseInt(rgbMatch[1]), parseInt(rgbMatch[2]), parseInt(rgbMatch[3])];
        }
        
        const hexMatch = colorString.match(/#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})/i);
        if (hexMatch) {
            return [
                parseInt(hexMatch[1], 16),
                parseInt(hexMatch[2], 16),
                parseInt(hexMatch[3], 16)
            ];
        }
        
        const shortHexMatch = colorString.match(/#([0-9a-f])([0-9a-f])([0-9a-f])/i);
        if (shortHexMatch) {
            return [
                parseInt(shortHexMatch[1] + shortHexMatch[1], 16),
                parseInt(shortHexMatch[2] + shortHexMatch[2], 16),
                parseInt(shortHexMatch[3] + shortHexMatch[3], 16)
            ];
        }
        
        return null;
    }

    // Function to invert dark colors to light
    function invertDarkColor(r, g, b) {
        return [255 - r, 255 - g, 255 - b];
    }

    // Inject script into all web pages
    const contentScript = function() {
        function adjustTextColor(element) {
            const computedStyle = window.getComputedStyle(element);
            const color = computedStyle.color;
            
            const rgb = parseColor(color);
            if (!rgb) return;
            
            const [r, g, b] = rgb;
            const luminosity = getLuminosity(r, g, b);
            
            if (luminosity < 0.5) {
                const [newR, newG, newB] = invertDarkColor(r, g, b);
                element.style.setProperty('color', `rgb(${newR}, ${newG}, ${newB})`, 'important');
            }
        }

        function processAllTextElements() {
            const textElements = document.querySelectorAll('p, span, div, h1, h2, h3, h4, h5, h6, a, li, td, th, label, button, input, textarea, select, option, strong, em, b, i, small, code, pre');
            textElements.forEach(element => adjustTextColor(element));
        }

        processAllTextElements();

        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                mutation.addedNodes.forEach((node) => {
                    if (node.nodeType === 1) {
                        adjustTextColor(node);
                        const children = node.querySelectorAll('p, span, div, h1, h2, h3, h4, h5, h6, a, li, td, th, label, button, input, textarea, select, option, strong, em, b, i, small, code, pre');
                        children.forEach(child => adjustTextColor(child));
                    }
                });
            });
        });

        observer.observe(document.body, {
            childList: true,
            subtree: true
        });

        setInterval(processAllTextElements, 1000);
    };

    // Convert functions to strings for injection
    const scriptContent = `
        ${getLuminosity.toString()}
        ${parseColor.toString()}
        ${invertDarkColor.toString()}
        (${contentScript.toString()})();
    `;

    // Listen for page loads and inject the script
    gBrowser.addTabsProgressListener({
        onLocationChange: function(aBrowser, aWebProgress, aRequest, aLocation, aFlags) {
            if (aWebProgress.isTopLevel) {
                aBrowser.messageManager.loadFrameScript('data:,(' + scriptContent + ')()', false);
            }
        }
    });

    // Also inject into existing tabs
    for (let tab of gBrowser.tabs) {
        tab.linkedBrowser.messageManager.loadFrameScript('data:,(' + scriptContent + ')()', false);
    }
})();
