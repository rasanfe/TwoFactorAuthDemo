forward
global type w_main from window
end type
type cb_1 from commandbutton within w_main
end type
type sle_key from singlelineedit within w_main
end type
type p_qrcode from picture within w_main
end type
type st_1 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_3 from statictext within w_main
end type
type sle_userid from singlelineedit within w_main
end type
type sle_application_name from singlelineedit within w_main
end type
type sle_token from singlelineedit within w_main
end type
type st_4 from statictext within w_main
end type
type cb_2 from commandbutton within w_main
end type
type p_2 from picture within w_main
end type
type st_info from statictext within w_main
end type
type st_myversion from statictext within w_main
end type
type st_platform from statictext within w_main
end type
type r_2 from rectangle within w_main
end type
end forward

global type w_main from window
integer width = 3982
integer height = 1784
boolean titlebar = true
string title = "GoogleAuthenticatorDemo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
sle_key sle_key
p_qrcode p_qrcode
st_1 st_1
st_2 st_2
st_3 st_3
sle_userid sle_userid
sle_application_name sle_application_name
sle_token sle_token
st_4 st_4
cb_2 cb_2
p_2 p_2
st_info st_info
st_myversion st_myversion
st_platform st_platform
r_2 r_2
end type
global w_main w_main

type prototypes

end prototypes

type variables

end variables

forward prototypes
public subroutine wf_version ()
end prototypes

public subroutine wf_version ();String ls_version, ls_platform
Integer li_rtn
Environment l_env

li_rtn = GetEnvironment(l_env)

IF li_rtn <> 1 THEN 
	ls_version = string(year(today()))
	ls_platform="32"
ELSE
	ls_version = "20"+ string(l_env.pbmajorrevision)+ "." + string(l_env.pbbuildnumber)
	ls_platform=string(l_env.ProcessBitness)
END IF

ls_platform += " Bits"

st_myversion.text=ls_version
st_platform.text=ls_platform

end subroutine

on w_main.create
this.cb_1=create cb_1
this.sle_key=create sle_key
this.p_qrcode=create p_qrcode
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.sle_userid=create sle_userid
this.sle_application_name=create sle_application_name
this.sle_token=create sle_token
this.st_4=create st_4
this.cb_2=create cb_2
this.p_2=create p_2
this.st_info=create st_info
this.st_myversion=create st_myversion
this.st_platform=create st_platform
this.r_2=create r_2
this.Control[]={this.cb_1,&
this.sle_key,&
this.p_qrcode,&
this.st_1,&
this.st_2,&
this.st_3,&
this.sle_userid,&
this.sle_application_name,&
this.sle_token,&
this.st_4,&
this.cb_2,&
this.p_2,&
this.st_info,&
this.st_myversion,&
this.st_platform,&
this.r_2}
end on

on w_main.destroy
destroy(this.cb_1)
destroy(this.sle_key)
destroy(this.p_qrcode)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_userid)
destroy(this.sle_application_name)
destroy(this.sle_token)
destroy(this.st_4)
destroy(this.cb_2)
destroy(this.p_2)
destroy(this.st_info)
destroy(this.st_myversion)
destroy(this.st_platform)
destroy(this.r_2)
end on

event open;wf_version()






end event

event closequery;
end event

event resize;r_2.width = newwidth
st_myversion.x = newwidth - st_myversion.width -20
st_platform.x = newwidth - st_myversion.width -20
st_info.x = newwidth - st_info.width -20
st_info.y = newheight - st_info.height  - 20

end event

type cb_1 from commandbutton within w_main
integer x = 1751
integer y = 384
integer width = 695
integer height = 160
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Generate QR Code"
end type

event clicked;String ls_QRCode

u_google_authenticator lnv_qa
ls_QRCode = lnv_qa.of_generateprovisioningimage ( sle_application_name.Text + ':' + sle_userid.Text, sle_key.Text)

p_qrcode.PictureName = ls_QRCode

end event

type sle_key from singlelineedit within w_main
integer x = 544
integer y = 736
integer width = 1134
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "12345678901234567890"
borderstyle borderstyle = stylelowered!
end type

type p_qrcode from picture within w_main
integer x = 2555
integer y = 384
integer width = 1317
integer height = 992
string picturename = "Google_Authenticator.png"
boolean focusrectangle = false
boolean map3dcolors = true
end type

type st_1 from statictext within w_main
integer x = 69
integer y = 736
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "Secret:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 69
integer y = 576
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "User ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_main
integer x = 69
integer y = 416
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "Application:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_userid from singlelineedit within w_main
integer x = 544
integer y = 576
integer width = 1134
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "rsrsystem.soft@gmail.com"
borderstyle borderstyle = stylelowered!
end type

type sle_application_name from singlelineedit within w_main
integer x = 544
integer y = 416
integer width = 1134
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "GoogleAuthenticatorDemo"
borderstyle borderstyle = stylelowered!
end type

type sle_token from singlelineedit within w_main
integer x = 544
integer y = 896
integer width = 1134
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_main
integer x = 69
integer y = 896
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "Token:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_main
integer x = 1751
integer y = 864
integer width = 695
integer height = 160
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Validate"
end type

event clicked;u_google_authenticator lnv_qa
string		ls_pin

ls_pin = lnv_qa.generatepin( sle_key.Text )

sle_token.Text = ls_pin

end event

type p_2 from picture within w_main
integer x = 5
integer y = 4
integer width = 1253
integer height = 248
boolean originalsize = true
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type st_info from statictext within w_main
integer x = 2615
integer y = 1604
integer width = 1289
integer height = 52
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 553648127
string text = "Copyright © Ramón San Félix Ramón  rsrsystem.soft@gmail.com"
boolean focusrectangle = false
end type

type st_myversion from statictext within w_main
integer x = 3415
integer y = 44
integer width = 489
integer height = 84
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Versión"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_platform from statictext within w_main
integer x = 3415
integer y = 132
integer width = 489
integer height = 84
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Bits"
alignment alignment = right!
boolean focusrectangle = false
end type

type r_2 from rectangle within w_main
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer width = 3936
integer height = 260
end type

