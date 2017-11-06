unit HelperUnit;

interface

uses
  FMX.Types, FMX.Controls,System.SysUtils
{$IFDEF ANDROID}
  //,Androidapi.JNI.Bridge,
  ,Androidapi.JNI.Speech,
  Androidapi.JNI.Os,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.WebKit,
  FMX.Helpers.Android,
  Androidapi.JNI.Net,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Telephony,
  Androidapi.JNI.App,
  Androidapi.Helpers
{$ENDIF}
{$IFDEF IOS}
    , iOSapi.Foundation, FMX.Helpers.iOS, System.iOS.Sensors
{$ENDIF IOS}
    ;

type
  THelperUnit = class(TObject)

  public
    function ValidEmail(email: string): boolean;
{$IFDEF ANDROID}
    function FetchSms: string;
{$ENDIF}
  end;

implementation

function THelperUnit.ValidEmail(email: string): boolean;
const
  atom_chars = [#33 .. #255] - ['(', ')', '<', '>', '@', ',', ';', ':', '\', '/', '"', '.', '[', ']', #127];
  quoted_string_chars = [#0 .. #255] - ['"', #13, '\'];
  letters = ['A' .. 'Z', 'a' .. 'z'];
  letters_digits = ['0' .. '9', 'A' .. 'Z', 'a' .. 'z'];
  subdomain_chars = ['-', '0' .. '9', 'A' .. 'Z', 'a' .. 'z'];
type
  States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR, STATE_QUOTE, STATE_LOCAL_PERIOD,
    STATE_EXPECTING_SUBDOMAIN, STATE_SUBDOMAIN, STATE_HYPHEN);
var
  State: States;
  i, n, subdomains: integer;
  c: char;
begin
  State := STATE_BEGIN;
  n := Length(email);
  i := 1;
  subdomains := 1;
  while (i <= n) do
  begin
    c := email[i];
    case State of
      STATE_BEGIN:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_ATOM:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else if not(c in atom_chars) then
          break;
      STATE_QTEXT:
        if c = '\' then
          State := STATE_QCHAR
        else if c = '"' then
          State := STATE_QUOTE
        else if not(c in quoted_string_chars) then
          break;
      STATE_QCHAR:
        State := STATE_QTEXT;
      STATE_QUOTE:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else
          break;
      STATE_LOCAL_PERIOD:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_EXPECTING_SUBDOMAIN:
        if c in letters then
          State := STATE_SUBDOMAIN
        else
          break;
      STATE_SUBDOMAIN:
        if c = '.' then
        begin
          inc(subdomains);
          State := STATE_EXPECTING_SUBDOMAIN
        end
        else if c = '-' then
          State := STATE_HYPHEN
        else if not(c in letters_digits) then
          break;
      STATE_HYPHEN:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else if c <> '-' then
          break;
    end;
    inc(i);
  end;
  if i <= n then
    Result := False
  else
    Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
end;

{$IFDEF ANDROID}

function THelperUnit.FetchSms: string;
var
  cursor: JCursor;
  uri: Jnet_Uri;
  address, person, msgdatesent, protocol, msgread, msgstatus, msgtype, msgreplypathpresent, subject, body,
    servicecenter, locked: string;
  msgunixtimestampms: int64;
  addressidx, personidx, msgdateidx, msgdatesentidx, protocolidx, msgreadidx, msgstatusidx, msgtypeidx,
    msgreplypathpresentidx, subjectidx, bodyidx, servicecenteridx, lockedidx: integer;
begin
  uri := StrToJURI('content://sms/inbox');
  cursor := TAndroidHelper.Activity.getContentResolver.query(uri, nil, nil, nil, nil);
  addressidx := cursor.getColumnIndex(StringToJString('address'));
  personidx := cursor.getColumnIndex(StringToJString('person'));
  msgdateidx := cursor.getColumnIndex(StringToJString('date'));
  msgdatesentidx := cursor.getColumnIndex(StringToJString('date_sent'));
  protocolidx := cursor.getColumnIndex(StringToJString('protocol'));
  msgreadidx := cursor.getColumnIndex(StringToJString('read'));
  msgstatusidx := cursor.getColumnIndex(StringToJString('status'));
  msgtypeidx := cursor.getColumnIndex(StringToJString('type'));
  msgreplypathpresentidx := cursor.getColumnIndex(StringToJString('reply_path_present'));
  subjectidx := cursor.getColumnIndex(StringToJString('subject'));
  bodyidx := cursor.getColumnIndex(StringToJString('body'));
  servicecenteridx := cursor.getColumnIndex(StringToJString('service_center'));
  lockedidx := cursor.getColumnIndex(StringToJString('locked'));

  while (cursor.moveToNext) do
  begin
    address := JStringToString(cursor.getString(addressidx));
    person := JStringToString(cursor.getString(personidx));
    msgunixtimestampms := cursor.getLong(msgdateidx);
    msgdatesent := JStringToString(cursor.getString(msgdatesentidx));
    protocol := JStringToString(cursor.getString(protocolidx));
    msgread := JStringToString(cursor.getString(msgreadidx));
    msgstatus := JStringToString(cursor.getString(msgstatusidx));
    msgtype := JStringToString(cursor.getString(msgtypeidx));
    msgreplypathpresent := JStringToString(cursor.getString(msgreplypathpresentidx));
    subject := JStringToString(cursor.getString(subjectidx));
    body := JStringToString(cursor.getString(bodyidx));
    servicecenter := JStringToString(cursor.getString(servicecenteridx));
    locked := JStringToString(cursor.getString(lockedidx));
    Result := IntToStr(trunc(msgunixtimestampms / 1000)) + ' ' + address + ' ' + body;
  end;
end;
{$ENDIF}

end.
