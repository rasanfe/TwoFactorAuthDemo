//objectcomments Generated Application Object
forward
global type twofactorauth from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_appdir
end variables

global type twofactorauth from application
string appname = "twofactorauth"
integer highdpimode = 0
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 25.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = "icono.ico"
string appruntimeversion = "25.0.0.3711"
boolean manualsession = false
boolean unsupportedapierror = false
boolean ultrafast = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global twofactorauth twofactorauth

type prototypes
//https://github.com/VFPX/FoxBarcodeQR
Function Boolean FastQRCode(String Texto,String FileName) Library "QRCodeLib.dll" ALIAS FOR "FastQRCode;Ansi"
Function Boolean FullQRCode(Integer AutoConfigurate,Integer AutoFit,Long Back, Long BarColor,String Texto,Integer CorrectionLevel,Integer Encoding,Integer MarginPixels,Integer ModuleWidth,Integer Heig,Integer Widt,String FileName) Library "QRCodeLib.dll" ALIAS FOR "FullQRCode;Ansi"

end prototypes

type variables

end variables

on twofactorauth.create
appname="twofactorauth"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on twofactorauth.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gs_appdir = getcurrentdirectory() +"\"
Open ( w_main )
end event

