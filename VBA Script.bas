Attribute VB_Name = "Module1"
Sub tickertotaler_moderate()

        Dim tickername As String
    
        Dim tickervolume As Double
        tickervolume = 0

        Dim summary_ticker_row As Integer
        summary_ticker_row = 2
        
        Dim open_price As Double
       
        open_price = Cells(2, 3).Value
        
        Dim close_price As Double
        Dim yearly_change As Double
        Dim percent_change As Double

        'Label the Summary Table headers
        Cells(1, 9).Value = "Ticker"
        Cells(1, 10).Value = "Yearly Change"
        Cells(1, 11).Value = "Percent Change"
        Cells(1, 12).Value = "Total Stock Volume"

        'Count the number of rows in the first column.
        lastrow = Cells(Rows.Count, 1).End(xlUp).Row

        'Loop through the rows by the ticker names

        For i = 2 To lastrow

        
            If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
        
              'Set the ticker name
              tickername = Cells(i, 1).Value

              'Add the volume of trade
              tickervolume = tickervolume + Cells(i, 7).Value

              'Print the ticker name in the summary table
              Range("I" & summary_ticker_row).Value = tickername

              'Print the trade volume for each ticker in the summary table
              Range("L" & summary_ticker_row).Value = tickervolume

              'information about closing price
              close_price = Cells(i, 6).Value

              'Calculate yearly change
              yearly_change = (close_price - open_price)
              
              'Print the yearly change for each ticker in the summary table
              Range("J" & summary_ticker_row).Value = yearly_change

             'Check for the non-divisibilty condition when calculating the percent change
                If (open_price = 0) Then

                    percent_change = 0

                Else
                    
                    percent_change = yearly_change / open_price
                
                End If

              'Print the yearly change for each ticker in the summary table
              Range("K" & summary_ticker_row).Value = percent_change
              Range("K" & summary_ticker_row).NumberFormat = "0.00%"
   
              'Reset the row counter. Add one to the summary_ticker_row
              summary_ticker_row = summary_ticker_row + 1

              'Reset volume of trade to zero
              tickervolume = 0

              'Reset the opening price
              open_price = Cells(i + 1, 3)
            
            Else
              
               'Add the volume of trade
              tickervolume = tickervolume + Cells(i, 7).Value

            
            End If
        
        Next i

    'Conditional formatting that will highlight positive change in green and negative change in red
    'First find the last row of the summary table

    lastrow_summary_table = Cells(Rows.Count, 9).End(xlUp).Row
    
    'Color code
    
    For i = 2 To lastrow_summary_table
            If Cells(i, 10).Value > 0 Then
                Cells(i, 10).Interior.ColorIndex = 10
            Else
                Cells(i, 10).Interior.ColorIndex = 3
            End If
    Next i

End Sub
