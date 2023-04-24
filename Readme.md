# Typst Templates

A collection of some `typst` templates.

Mainly used to create worksheets and exams for my classes. 


## VS Code integration

Activate [typst-lsp](https://open-vsx.org/extension/nvarner/typst-lsp) extention for better syntax highlightning.

And add the following to `settings.json` if you don't want to compile the templates on saving the file.

```json
{
    "typst-lsp.exportPdf": "never",
    "typst-lsp.serverPath": ""
}
```