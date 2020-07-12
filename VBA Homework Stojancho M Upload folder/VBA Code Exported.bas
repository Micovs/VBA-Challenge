Attribute VB_Name = "Module1"
Sub Stock_Sumarizer()

  'Define variables
  Dim Stock_Name As String
  
  Dim i As Variant
  
  Dim Total_volume As Double
  Total_volume = 0

  Dim Ticker_Row_tracker As Integer
  Ticker_Row_tracker = 2
  
  Dim first_time_same_counter As Integer
  first_time_same_counter = 0
  
  Dim open_price As Double
  open_price = 0
  
  Dim close_price As Double
  close_price = 0
  
  Dim Yearly_change As Double
  
  Dim Percent_change As Variant
    
  Dim Greatest_TV As Double
  
  Dim Greatest_Percent_Increase As Double
  
  Dim RowCountA As Long
  
  Dim RowCountL As Integer
  
  ' get the row number of the last row with data at colum A
  
    RowCountA = Cells(Rows.Count, "A").End(xlUp).Row
  
  ' As a test put to 500, change to last cell of workseet later, aquired by RowcountA
  For i = 2 To RowCountA

    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then

      ' Set the stock name. First time the two ticker will be diferent, the if statement will activate and the name of the stock will be cell(i,7)
      Stock_Name = Cells(i, 1).Value

      ' Add to the Total volume. The total volume was summarizing every time the if statement did not activate, since the stock was same.
      ' This will be the last addition before reseting to 0.
      Total_volume = Total_volume + Cells(i, 7).Value

      ' Print the stock name in the ticker colum
      Range("I" & Ticker_Row_tracker).Value = Stock_Name

      ' Print the Total volume to the volume colum
      Range("L" & Ticker_Row_tracker).Value = Total_volume
              
      ' Remembers the close price
      close_price = Cells(i, 6).Value
      
      ' Calculates yearly change
      Yearly_change = close_price - open_price
      
      ' Prints yearly change
      Range("J" & Ticker_Row_tracker).Value = Yearly_change
      
      'Formats the cell color depending on value of Yearly_change
        If Yearly_change > 0 Then
            Range("J" & Ticker_Row_tracker).Interior.ColorIndex = 4
        Else
            Range("J" & Ticker_Row_tracker).Interior.ColorIndex = 3
        
        End If
         
         
      'Checks to see if open_price is 0 to avoid division by 0
        If open_price = 0 Then
            Range("K" & Ticker_Row_tracker).Value = "0"
            
        Else
        
            'Calculates percent_change
            Percent_change = Yearly_change / open_price * 100
     
      
            'formats percent_change to 2 decimals and sign %
            Percent_change = Format(Percent_change, "%0.00")
      
          
            'prints percent change
            Range("K" & Ticker_Row_tracker).Value = Percent_change
            
         End If
         
      
      ' Add one to the Ticker_Row_tracker
      Ticker_Row_tracker = Ticker_Row_tracker + 1
      
      ' Reset the Total_volume
      Total_volume = 0
      
      ' Resets the first time counter
      first_time_same_counter = 0
      

    'If the cell immediately following a row is the same brand......
    Else

      ' Add to the Brand Total
      Total_volume = Total_volume + Cells(i, 7).Value

    End If
    
    'Finds and stores the open_price value
    
    If first_time_same_counter = 0 Then
    
        If Cells(i + 1, 1).Value = Cells(i, 1).Value Then
        
        open_price = Cells(i, 3).Value
        
        first_time_same_counter = first_time_same_counter + 1
        
        End If
    End If
    
  Next i
  
  '********CHALENGES********
  
   Dim Greatest_Percent_Decrease As Double
     
   'Initial values that i compare with,
   'and print in case the first value is the greatest
   
    Greatest_TV = Cells(2, 12).Value
    Range("Q4").Value = Greatest_TV
    Range("P4").Value = Cells(2, 9).Value
   
    Greatest_Percent_Increase = Cells(2, 11).Value
    Range("Q2").Value = Greatest_Percent_Increase
    Range("P2").Value = Cells(2, 9).Value
   
    Greatest_Percent_Decrease = Cells(2, 11).Value
    Range("Q3").Value = Greatest_Percent_Decrease
    Range("P3").Value = Cells(2, 9).Value
    
    ' get the row number of the last row with data at colum L
  
    RowCountL = Cells(Rows.Count, "L").End(xlUp).Row
   
For i = 2 To RowCountL
   
    If Cells(i + 1, 12).Value > Greatest_TV Then
    
        Greatest_TV = Cells(i + 1, 12).Value
        Range("Q4").Value = Greatest_TV
        Range("P4").Value = Cells(i + 1, 9).Value
    
    End If
       
    If Cells(i + 1, 11).Value > Greatest_Percent_Increase Then
    
        Greatest_Percent_Increase = Cells(i + 1, 11).Value
        Range("Q2").Value = Greatest_Percent_Increase
        Range("P2").Value = Cells(i + 1, 9).Value
    
    End If
    
    If Cells(i + 1, 11).Value < Greatest_Percent_Decrease Then
    
        Greatest_Percent_Decrease = Cells(i + 1, 11).Value
        Range("Q3").Value = Greatest_Percent_Decrease
        Range("P3").Value = Cells(i + 1, 9).Value
    
    End If
    
Next i
  
    

End Sub

