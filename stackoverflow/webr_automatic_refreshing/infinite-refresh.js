// import the webr module and then run the code
import('https://webr.r-wasm.org/latest/webr.mjs').then(async ({WebR}) => {

    // wait for the webR session to start
    const webr = new WebR();
    await webr.init();
    
    // search DOM for the cb1 cell code and associated output element
    let cb1Code;
    let cb1OutputElement;
    let cells = document.querySelectorAll('.cell');
    cells.forEach(cell => {
        let codeElement = cell.querySelector('div.sourceCode.cell-code');
        // not all cells have code elements (e.g., echo=FALSE)
        if(codeElement) {
            // if code element id is cb1, we are currently on the desired cell
            if(codeElement.getAttribute("id") == 'cb1') {
                cb1Code = codeElement.querySelector('pre > code').innerText;
                cb1OutputElement = cell.querySelector(
                    'div.cell-output.cell-output-stdout > pre > code'
                );
            }
        }
    })

    // async function to rerun r code and update output every second
    var cb1OutputUpdate = async function() {
        let s = await webr.evalR(cb1Code);
        cb1OutputElement.innerText = `[1] "${(await s.toJs()).values}"`;
        setTimeout(cb1OutputUpdate, 1000);
    }

    cb1OutputUpdate();
});
