# 17. Printing

## Learning Objectives

- Configure printers and print jobs under Linux.
- Manipulate PostScript and PDF files for printing workflows.

## Key Concepts Explained

- **Printing Architecture**
  - CUPS as the common print server; drivers and PPD files.
  - Print queues, lp/lpr tools, and GUI print dialogs.

- **Document Manipulation**
  - Using `lp`, `lpr`, `pdfinfo`, `pstops`, and `convert` (ImageMagick) to prepare files.

## Commands & Examples

```bash
# Show printers
lpstat -p -d

# Send a PDF to default printer
lp document.pdf

# Convert PostScript to PDF
ps2pdf file.ps file.pdf
```

## Real-World Usage Scenarios

- Setting up a shared network printer on a small office LAN.
- Batch-printing PDF invoices from a headless server.

## Common Mistakes & Best Practices

- Mistake: Leaving open print queues when drivers misbehave.
- Best practice: Test driver compatibility and provide a clear admin account for printer management.

## Summary

Printing on Linux centers on CUPS and common command-line utilities; understanding queues and formats enables automation and troubleshooting.
