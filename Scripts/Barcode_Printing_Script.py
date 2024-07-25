import os
import pandas as pd
from reportlab.pdfgen import canvas
from reportlab.lib.units import cm
from reportlab.graphics.barcode import code128

def generate_barcodes_from_csv(csv_file, output_pdf):
    # Read the CSV file
    df = pd.read_csv(csv_file)

    

    # Get the list of IDs from the first column
    barcodes = df.iloc[:, 0].tolist()

    # Create directories if they don't exist
    output_pdf_directory = r"C:\Users\quasid.akhter\Desktop\Barcode\Output_PDFS"
    if not os.path.exists(output_pdf_directory):
        os.makedirs(output_pdf_directory)

    # Construct the output PDF path
    output_pdf_path = os.path.join(output_pdf_directory, output_pdf)

    # Create a canvas for the PDF
    c = canvas.Canvas(output_pdf_path, pagesize=(7.5*cm, 9.5*cm))

    barcode_width = 1.5*cm  # Set the barcode width
    barcode_height = 0.12*cm  # Set the barcode height
    x_spacing = 0.33*cm  # Set the horizontal spacing between barcodes
    y_spacing = 0.92*cm  # Set the vertical spacing between rows
    page_width = 6*cm
    page_height = 7*cm
    x_start = (page_width - (4 * barcode_width + x_spacing)) / 2 - 0.23*cm  # Adjusted to move left
    y_start = 8.6*cm  # Starting y-coordinate for the first row

    for i in range(0, len(barcodes), 40):
        x, y = x_start, y_start

        for j, barcode_data in enumerate(barcodes[i:i+40]):
            # Optimize barcode width for better clarity while keeping the height same
            barcode = code128.Code128(barcode_data, barWidth=0.43, barHeight=5.7)  # Slightly increased barWidth for better clarity
            barcode.drawOn(c, x, y - barcode_height)
            text_width = c.stringWidth(barcode_data, "Helvetica-Bold", 8)  # Get the width of the text with font size 8
            text_x = x + (barcode_width - text_width) / 2 +0.5*cm # Calculate the x-coordinate to center the text
            c.setFont("Helvetica-Bold", 5.6)  # Set the font to bold
            c.drawString(text_x, y - barcode_height - 0.17*cm, barcode_data)  # Write barcode ID below the barcode
            x += barcode_width + x_spacing  # Move to the next barcode position
            if (j + 1) % 4 == 0:
                x = x_start
                y -= y_spacing  # Move to the next row
        if i + 40 < len(barcodes):
            c.showPage()  # Add a new page if there are more barcodes to process

    c.save()
    print(f"PDF saved as {output_pdf_path}")

# Example usage
multiplex_directory = r"C:\Users\quasid.akhter\Desktop\Barcode\Output_files"  # Specify your input directory here
input_csv_file = os.path.join(multiplex_directory, "NIO_Day3_Plasma_Sec_Ids.csv")
output_pdf = "NIO_Day3_Plasma_Sec_Ids.pdf"  # Name of the output PDF file
generate_barcodes_from_csv(input_csv_file, output_pdf)