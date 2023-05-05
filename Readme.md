# Typst Templates

A collection of some `typst` templates.

Mainly used to create worksheets and exams for my classes. 

## Usage

At the moment there are 2 templates

+ one for creating worksheets for my lessons
+ another for creating exams.

### Create an Exam
```
#show: exam.with(
    kind: "Schulaufgabe",  // specifiy the kind of exam
    date: "1.5.2023",
    class: "12b",
    subject: "IT-Systeme", 
    authors: ("JM"),
    aids: "TR", // Permitted aids -> default: none else takes a string.
    lsg: false, // if true it will show the content of #solution[] in a red color. 
)

#task[ This is the first task it has a build in counter which will count tasks. ]
#question(points: 2)[This will be question a) for task 1]
#solution[If you want you can describe some solution here.]
#question(points: 2)[This will be question b) for task 1]

```
See example folder for further examples and usecases.

## VS Code integration

Activate [typst-lsp](https://open-vsx.org/extension/nvarner/typst-lsp) extention for better syntax highlightning.

And add the following to `settings.json` if you don't want to compile the templates on saving the file.

```json
{
    "typst-lsp.exportPdf": "never",
}
```

# Credits

Credits to some people which templates i used or extended for my usecase.

- [lkoehl](https://github.com/lkoehl/typst-boxes) for colorbox
- [lostpy](https://gitlab.com/LostPy/lostpy-typst-templates) for code-box

