//
//  ViewController.swift
//  Simple PDFKit
//
//  Created by RAMDHAN CHOUDHARY on 15/05/19.
//  Copyright © 2019 RDC. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    //Get document dir path where we need to store our PDF file
    let  documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    var filePath:String!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Create new PDF document
    @IBAction func createPDF(_ sender: Any) {

        filePath = (documentsDirectory as NSString).appendingPathComponent("my_pdf.pdf") as String
        let pdfTitle = "Swift-Generated PDF Document"
        let pdfMetadata = [
            // The name of the application creating the PDF.
            kCGPDFContextCreator: "Your iOS App",
            // The name of the PDF's author.
            kCGPDFContextAuthor: "RDC",
            // The title of the PDF.
            kCGPDFContextTitle: "Lorem Ipsum",
        ]
        
        // Creates a new PDF file at the specified path.
        UIGraphicsBeginPDFContextToFile(filePath, CGRect.zero, pdfMetadata)
        
        // Creates a new page in the current PDF context.
        UIGraphicsBeginPDFPage()
        
        // Default size of the page is 612x72.
        let pageSize = UIGraphicsGetPDFContextBounds().size
        let font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        // Let's draw the title of the PDF on top of the page.
        let attributedPDFTitle = NSAttributedString(string: pdfTitle, attributes: [NSAttributedString.Key.font: font])
        let stringSize = attributedPDFTitle.size()
        let stringRect = CGRect(x: (pageSize.width / 2 - stringSize.width / 2), y: 20, width: stringSize.width, height: stringSize.height)
        attributedPDFTitle.draw(in: stringRect)
        
        // Closes the current PDF context and ends writing to the file.
        UIGraphicsEndPDFContext()

        
    }
    
    //View PDF document
    @IBAction func viewPDF(_ sender: Any)
    {
        if((filePath) != nil)//Check for file availablity
        {
            let pdfView = PDFView(frame: containerView.bounds)
            pdfView.autoScales = true
            containerView.addSubview(pdfView)
            
            // Create a PDFDocument object and set it as PDFView's document to load the document in that view.
            let pdfDocument = PDFDocument(url: URL(fileURLWithPath: filePath))!
            pdfView.document = pdfDocument
        }
        
    }
    
    // Adding an annotation to PDF
    @IBAction func addAnnotation(_ sender: Any)
    {
        if((filePath) != nil)//Check for file availablity
        {
            let squareAnnotation = PDFAnnotation(bounds: CGRect(x: 150, y: 150, width: 80, height: 80), forType: PDFAnnotationSubtype.square, withProperties: nil)
            squareAnnotation.color = UIColor.blue
            let pdfDocument = PDFDocument(url: URL(fileURLWithPath: filePath))!
            let page = pdfDocument.page(at: 0)!
            page.addAnnotation(squareAnnotation)
            // Writing the changes to the file.
            pdfDocument.write(toFile: self.filePath)
        }
    }
}

