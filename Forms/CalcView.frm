VERSION 5.00
Begin VB.Form CalcView 
   BorderStyle     =   1  'Fest Einfach
   Caption         =   "Form1"
   ClientHeight    =   2295
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   6615
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2295
   ScaleWidth      =   6615
   StartUpPosition =   3  'Windows-Standard
   Begin VB.ListBox List1 
      Height          =   1620
      Left            =   120
      TabIndex        =   5
      Top             =   600
      Width           =   6375
   End
   Begin VB.ComboBox CmbOperator 
      BeginProperty Font 
         Name            =   "Consolas"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      ItemData        =   "CalcView.frx":0000
      Left            =   1680
      List            =   "CalcView.frx":0010
      TabIndex        =   4
      Text            =   " + "
      Top             =   120
      Width           =   855
   End
   Begin VB.TextBox TxtCalcSolution 
      Alignment       =   1  'Rechts
      Height          =   360
      Left            =   4920
      TabIndex        =   3
      Top             =   120
      Width           =   1575
   End
   Begin VB.CommandButton BtnCalculate 
      Caption         =   " = "
      Height          =   375
      Left            =   4200
      TabIndex        =   2
      Top             =   120
      Width           =   615
   End
   Begin VB.TextBox TxtSecndNum 
      Alignment       =   1  'Rechts
      Height          =   360
      Left            =   2520
      TabIndex        =   1
      Top             =   120
      Width           =   1575
   End
   Begin VB.TextBox TxtFirstNum 
      Alignment       =   1  'Rechts
      Height          =   360
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1575
   End
End
Attribute VB_Name = "CalcView"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'Derek Banas MVC Java Tutorial on YT:
'https://www.youtube.com/watch?v=dTVVa2gfht8

'// This is the View
'// Its only job is to display what the user sees
'// It performs no calculations, but instead passes
'// information entered by the user to whomever needs
'// it.
Private m_ActionListeners As New Collection

'setting up the components in code is not needed here, it is done in the visual form-editor of VB

Public Property Get FirstNum() As Double
    If Double_TryParse(TxtFirstNum.Text, FirstNum) Then Exit Property
    Err.Description = "Please give a valid numeric value: """ & TxtFirstNum.Text & """ is not a number"
    Err.Raise 5
End Property

Public Property Get SecndNum() As Double
    If Double_TryParse(TxtSecndNum.Text, SecndNum) Then Exit Property
    Err.Description = "Please give a valid numeric value: """ & TxtSecndNum.Text & """ is not a number"
    Err.Raise 5
End Property

Public Sub UpdateView(m As CalcModel)
    TxtCalcSolution.Text = m.CalcValue
End Sub

Public Sub DisplayErrorMessage(errMess As String)
    MsgBox errMess, vbCritical
End Sub


'// If the calculateButton is clicked execute a method
'// in the Controller named actionPerformed
Public Sub addCalculateListener(listener As ActionListener)
    m_ActionListeners.Add listener
End Sub

Private Sub BtnCalculate_Click()
    Dim al As ActionListener
    For Each al In m_ActionListeners
        al.ActionPerformed MNew.ActionEvent(BtnCalculate)
    Next
End Sub

Private Sub CmbOperator_Click()
    Dim al As ActionListener
    For Each al In m_ActionListeners
        al.ActionPerformed MNew.ActionEvent(CmbOperator, CmbOperator.ListIndex)
    Next
End Sub

'// This is the View
'// Its only job is to display what the user sees
'// It performs no calculations, but instead passes
'// information entered by the user to whomever needs
'// it.
'
'import java.awt.event.ActionListener;
'
'import javax.swing.*;
'
'public class CalculatorView extends JFrame{
'
'    private JTextField firstNumber  = new JTextField(10);
'    private JLabel additionLabel = new JLabel("+");
'    private JTextField secondNumber = new JTextField(10);
'    private JButton calculateButton = new JButton("Calculate");
'    private JTextField calcSolution = new JTextField(10);
'
'    CalculatorView(){
'
'        // Sets up the view and adds the components
'
'        JPanel calcPanel = new JPanel();
'
'        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
'        this.setSize(600, 200);
'
'        calcPanel.add(firstNumber);
'        calcPanel.add(additionLabel);
'        calcPanel.add(secondNumber);
'        calcPanel.add(calculateButton);
'        calcPanel.add(calcSolution);
'
'        this.add(calcPanel);
'
'        // End of setting up the components --------
'
'    }
'
'    public int getFirstNumber(){
'
'        return Integer.parseInt(firstNumber.getText());
'
'    }
'
'    public int getSecondNumber(){
'
'        return Integer.parseInt(secondNumber.getText());
'
'    }
'
'    public int getCalcSolution(){
'
'        return Integer.parseInt(calcSolution.getText());
'
'    }
'
'    public void setCalcSolution(int solution){
'
'        calcSolution.setText(Integer.toString(solution));
'
'    }
'
'    // If the calculateButton is clicked execute a method
'    // in the Controller named actionPerformed
'
'    void addCalculateListener(ActionListener listenForCalcButton){
'
'        calculateButton.addActionListener(listenForCalcButton);
'
'    }
'
'    // Open a popup that contains the error message passed
'
'    void displayErrorMessage(String errorMessage){
'
'        JOptionPane.showMessageDialog(this, errorMessage);
'
'    }
'
'}

