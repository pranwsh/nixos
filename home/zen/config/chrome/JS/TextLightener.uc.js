// ==UserScript==
// @name           TextLightener
// @description    Makes dark text lighter on all web pages
// @include        main
// @compatibility  Firefox 120+ (Fission-safe)
// ==/UserScript==

(function() {
    if (!window.gBrowser) return;

    const scriptToInject = `
        (() => {
            function getLuminosity(r,g,b){
                const [rs,gs,bs]=[r,g,b].map(c=>{
                    c=c/255;
                    return c<=0.03928?c/12.92:Math.pow((c+0.055)/1.055,2.4);
                });
                return 0.2126*rs+0.7152*gs+0.0722*bs;
            }

            function parseColor(s){
                const m=s.match(/rgba?\\((\\d+),(\\d+),(\\d+)/);
                if(m) return m.slice(1,4).map(Number);
                const h=s.match(/#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})/i);
                if(h) return [parseInt(h[1],16),parseInt(h[2],16),parseInt(h[3],16)];
                const sh=s.match(/#([0-9a-f])([0-9a-f])([0-9a-f])/i);
                if(sh) return [parseInt(sh[1]+sh[1],16),parseInt(sh[2]+sh[2],16),parseInt(sh[3]+sh[3],16)];
                return null;
            }

            function invertDarkColor(r,g,b){return [255-r,255-g,255-b];}

            function adjustTextColor(el){
                const cs=getComputedStyle(el);
                const rgb=parseColor(cs.color);
                if(!rgb) return;
                const lum=getLuminosity(...rgb);
                if(lum<0.5){
                    const[nr,ng,nb]=invertDarkColor(...rgb);
                    el.style.setProperty("color", \`rgb(\${nr},\${ng},\${nb})\`, "important");
                }
            }

            function processAll(){
                document.querySelectorAll("p,span,div,h1,h2,h3,h4,h5,h6,a,li,td,th,label,button,input,textarea,select,option,strong,em,b,i,small,code,pre")
                    .forEach(adjustTextColor);
            }

            processAll();
            new MutationObserver(processAll).observe(document.body,{childList:true,subtree:true});
            setInterval(processAll,1000);
        })();
    `;

    // Inject the script safely into a tab
    function injectIntoTab(browser) {
        if (!browser?.browsingContext) return;
        try {
            browser.browsingContext.currentWindowGlobal
                .getActor("WebNavigation")
                .documentPrincipal; // ensure it’s live
            browser.messageManager ?? browser.frameLoader?.messageManager;
            browser.browsingContext.topChromeWindow?.setTimeout(() => {
                browser.browsingContext.window?.eval(scriptToInject);
            }, 1000);
        } catch (e) {
            // fallback: use evalInWindowGlobal if supported
            try {
                browser.browsingContext.currentWindowGlobal
                    .evalInWindowGlobal(scriptToInject);
            } catch (_) {}
        }
    }

    // Inject when a tab loads
    gBrowser.tabContainer.addEventListener("TabSelect", e => {
        let browser = gBrowser.selectedBrowser;
        injectIntoTab(browser);
    });

    gBrowser.addTabsProgressListener({
        onLocationChange: (browser, wp, rq, loc) => {
            if (wp.isTopLevel) injectIntoTab(browser);
        }
    });

    // Also run for existing tabs at startup
    for (let tab of gBrowser.tabs) {
        injectIntoTab(tab.linkedBrowser);
    }
})();
