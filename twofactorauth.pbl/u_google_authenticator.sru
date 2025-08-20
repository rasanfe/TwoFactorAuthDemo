forward
global type u_google_authenticator from nonvisualobject
end type
end forward

global type u_google_authenticator from nonvisualobject autoinstantiate
end type

type prototypes
Function ulong GetTimeZoneInformation (ref TIME_ZONE_INFORMATION lpTimeZoneInformation) Library "kernel32"
Function boolean TzSpecificLocalTimeToSystemTime(TIME_ZONE_INFORMATION lpTimeZone, SYSTEMTIME lpLocalTime, ref SYSTEMTIME lpUniversalTime) Library "kernel32"
end prototypes

type variables

end variables

forward prototypes
public function string generatepin (string key)
public function string generatepin (string key, long counter)
public function integer longtobytearray (long al_data, ref byte a_data[])
public function byte bitwiseand (byte a_value1, byte a_value2)
public function long getunixepoch ()
public function integer of_copylongtobytes (long al_long, ref byte a_byte[4])
public function blob of_blob (byte a_byte[])
public function string of_generateprovisioningimage (string identifier, string key)
end prototypes

public function string generatepin (string key);long	TotalSeconds, CurrentInterval, IntervalLength = 30

TotalSeconds = getunixepoch()
CurrentInterval = TotalSeconds/IntervalLength

return generatepin ( key, CurrentInterval )
end function

public function string generatepin (string key, long counter);byte				hashBytes[], counterBytes[], offset, selectedByte
blob				counterHashBlob, counterBlob, keyBlob
string				counterHash, pin
integer			li_count, i, pinLen
long				selectedLong
long				selectedMod
CrypterObject 	co

//Convert the counter to byte array and then to blob
longtobytearray ( counter, counterBytes )
counterBlob = of_blob ( counterBytes )

//Convert key to blob and has counter
keyBlob= Blob ( key, EncodingUTF8! )
co = create CrypterObject
counterHashBlob = co.Hmac( HMACSHA1! , counterBlob, keyBlob )
Destroy co

//Convert result back to byte array
hashBytes = GetByteArray ( counterHashBlob )

//Get the last byte
li_count = UpperBound ( hashBytes )
//And use that to determine the offset into the byte array that we'll start with
offset = bitwiseand ( hashBytes[li_count], 15 )

//Calculate the selectedLong value using the selected bytes
for i = 1 to 4
	selectedByte = 	hashBytes[offset + i]
	CHOOSE CASE i
		CASE 1
			//Strip the most significant bit
			selectedByte = bitwiseand ( selectedByte, 127 )	
			selectedLong = selectedLong + selectedByte * 2^24
		CASE 2
			selectedLong = selectedLong + selectedByte * 2^16
		CASE 3
			selectedLong = selectedLong + selectedByte * 2^8
		CASE 4
			selectedLong = selectedLong + selectedByte
	END CHOOSE
next

selectedMod = Mod ( selectedLong, 1000000 )

pin = String ( selectedMod )
pinLen = Len ( pin )
pin = Fill ( '0', 6 - pinLen ) + pin

Return pin
end function

public function integer longtobytearray (long al_data, ref byte a_data[]);byte		l_data[4]
long		l_len = 4
integer	i, j

of_copylongtobytes ( al_data, l_data )

//pad with 4 zeros
for i = 1 To 4
	j = UpperBound(a_data) +1
	a_data[j] = 0
next

//Copy over data in inverse order
for i = 4 to 1 STEP -1
	j = UpperBound (a_data) + 1 
	a_data[j] = l_data[i]
next


Return 1
end function

public function byte bitwiseand (byte a_value1, byte a_value2);Integer li_i
Byte     lbyte_result, lbyte_factor

lbyte_result = 0
For li_i = 1 To 8

	If a_value1 = 0 Or a_value2 = 0 Then Exit
	
	If li_i = 1 Then
		lbyte_factor = 1
	Else
		lbyte_factor *= 2
	End If
	
	If Mod(a_value1, 2) = 1 And Mod(a_value2, 2) = 1 Then
		lbyte_result += lbyte_factor
	End If
	
	a_value1 /= 2
	a_value2 /= 2
Next

Return lbyte_result
end function

public function long getunixepoch ();long	days
long	seconds
long 	epoch
ulong rc1
boolean rc2
TIME_ZONE_INFORMATION tzi
SYSTEMTIME local
SYSTEMTIME utc
datetime	l_datetime_utc

rc1 = GetTimeZoneInformation(tzi)

//Convert PowerBuilder datetime to SYSTEMTIME
local.wYear = Year(Today())
local.wMonth = Month(Today())
local.wDay = Day(Today())
local.wHour = Hour(Now())
local.wMinute = Minute(Now())
local.wSecond = Second(Now())
local.wMilliseconds = 0

//Get the time in UTC
rc2 = TzSpecificLocalTimeToSystemTime(tzi, local, utc)

//Convert the UTC SYSTEMTIME back to a PowerBuilder datetime
l_datetime_utc = DateTime ( Date ( utc.wYear, utc.wMonth, utc.wDay ), Time ( utc.wHour, utc.wMinute, utc.wSecond ) )

days = DaysAfter ( Date ( '1970/01/01' ), Date ( l_datetime_utc ) )
seconds = SecondsAfter ( Time ( '00:00:00' ), Time ( l_datetime_utc ) )
epoch = ( days * 24 * 60 * 60 ) + seconds
Return epoch

end function

public function integer of_copylongtobytes (long al_long, ref byte a_byte[4]);long ll_long
integer i = 1, j, li_byte[]

ll_long = al_long

Do While Truncate(ll_long / 256, 0) > 0
	li_byte[i] = Mod(ll_long, 256)
	i++
	ll_long = Truncate(ll_long/256, 0)
Loop

li_byte[i] = Mod(ll_long, 256)

For j = 1 to i
	a_byte[j] += Byte(String(li_byte[j]))
Next

Return 1
end function

public function blob of_blob (byte a_byte[]);Integer i
Blob lblb

lblb = Blob ( Space(UpperBound(a_byte)), EncodingUTF8! )
for i = 1 to UpperBound(a_byte)
	SetByte(lblb, i, a_byte[i])
Next

Return lblb
end function

public function string of_generateprovisioningimage (string identifier, string key);String				ls_keystring, ls_provision_url, ls_ruta
CoderObject		ln_Coder
nvo_barcode lo_qr

ln_Coder = create CoderObject
lo_qr = CREATE nvo_barcode

ls_keystring = ln_Coder.base32encode( Blob ( key, EncodingUTF8! ) )
ls_provision_url = 'otpauth://totp/' + identifier + '?secret=' + ls_keystring 
ls_Ruta = lo_qr.of_genera_qr(ls_provision_url)

Destroy ln_Coder
Destroy lo_qr

Return ls_Ruta
end function

on u_google_authenticator.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_google_authenticator.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

