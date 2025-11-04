// ==UserScript==
// @name           TextLightener
// @description    Makes dark webpage text lighter
// @include        main
// @grant          none
// ==/UserScript==

(function() {
  if (!window.Nebula) {
    console.warn("[TextLightener] Nebula not ready yet. Waiting...");
    document.addEventListener("NebulaReady", () => initModule(), { once: true });
  } else {
    initModule();
  }

  function initModule() {
    class TextLightenerModule {
      constructor() {
        this._interval = null;
      }

      init() {
        Nebula.logger.log("✅ [TextLightener] Initialized");

        const code = `(() => {
          function getLuminosity(r,g,b){
            const [rs,gs,bs]=[r,g,b].map(c=>{
              c=c/255;
              return c<=0.03928?c/12.92:Math.pow((c+0.055)/1.055,2.4);
            });
            return 0.2126*rs+0.7152*gs+0.0722*bs;
          }
          function parseColor(s){
            const m=s.match(/rgba?\\((\\d+),(\\d+),(\\d+)/);
            if(m)return m.slice(1,4).map(Number);
            const h=s.match(/#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})/i);
            if(h)return [parseInt(h[1],16),parseInt(h[2],16),parseInt(h[3],16)];
            return null;
          }
          function invertDarkColor(r,g,b){return [255-r,255-g,255-b];}
          function adjustTextColor(e){
            const cs=getComputedStyle(e);
            const rgb=parseColor(cs.color);
            if(!rgb)return;
            const lum=getLuminosity(...rgb);
            if(lum<0.5){
              const[nr,ng,nb]=invertDarkColor(...rgb);
              e.style.setProperty('color',\`rgb(\${nr},\${ng},\${nb})\`,'important');
            }
          }
          function processAll(){
            document.querySelectorAll('p,span,div,h1,h2,h3,h4,h5,h6,a,li,td,th,label,button,input,textarea,select,option,strong,em,b,i,small,code,pre')
              .forEach(adjustTextColor);
          }
          processAll();
          new MutationObserver(processAll).observe(document.body,{subtree:true,childList:true});
          setInterval(processAll,1000);
        })();`;

        // Run in all existing and future tabs
        for (let tab of gBrowser.tabs) {
          let browser = tab.linkedBrowser;
          browser.browsingContext.window?.eval(code);
        }

        gBrowser.addTabsProgressListener({
          onLocationChange: (browser, wp, rq, loc) => {
            if (wp.isTopLevel) browser.browsingContext.window?.eval(code);
          }
        });
      }

      destroy() {
        Nebula.logger.log("🧹 [TextLightener] Destroyed");
      }
    }

    Nebula.register(TextLightenerModule);
  }
})();
