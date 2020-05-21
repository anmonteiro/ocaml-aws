open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetSessionTokenRequest =
  struct
    type t =
      {
      duration_seconds: Integer.t option
        [@ocaml.doc
          "<p>The duration, in seconds, that the credentials should remain valid. Acceptable durations for IAM user sessions range from 900 seconds (15 minutes) to 129,600 seconds (36 hours), with 43,200 seconds (12 hours) as the default. Sessions for AWS account owners are restricted to a maximum of 3,600 seconds (one hour). If the duration is longer than one hour, the session for AWS account owners defaults to one hour.</p>"];
      serial_number: String.t option
        [@ocaml.doc
          "<p>The identification number of the MFA device that is associated with the IAM user who is making the <code>GetSessionToken</code> call. Specify this value if the IAM user has a policy that requires MFA authentication. The value is either the serial number for a hardware device (such as <code>GAHT12345678</code>) or an Amazon Resource Name (ARN) for a virtual device (such as <code>arn:aws:iam::123456789012:mfa/user</code>). You can find the device for an IAM user by going to the AWS Management Console and viewing the user's security credentials. </p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@:/-</p>"];
      token_code: String.t option
        [@ocaml.doc
          "<p>The value provided by the MFA device, if MFA is required. If any policy requires the IAM user to submit an MFA code, specify this value. If MFA authentication is required, the user must provide a code when requesting a set of temporary security credentials. A user who fails to provide the code receives an \"access denied\" response when requesting resources that require MFA authentication.</p> <p>The format for this parameter, as described by its regex pattern, is a sequence of six numeric digits.</p>"]}
    let make ?duration_seconds  ?serial_number  ?token_code  () =
      { duration_seconds; serial_number; token_code }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.token_code
              (fun f -> ("token_code", (String.to_json f)));
           Util.option_map v.serial_number
             (fun f -> ("serial_number", (String.to_json f)));
           Util.option_map v.duration_seconds
             (fun f -> ("duration_seconds", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          duration_seconds =
            (Util.option_bind (Xml.member "DurationSeconds" xml)
               Integer.parse);
          serial_number =
            (Util.option_bind (Xml.member "SerialNumber" xml) String.parse);
          token_code =
            (Util.option_bind (Xml.member "TokenCode" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.duration_seconds
                (fun f ->
                   Ezxmlm.make_tag "DurationSeconds" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.serial_number
               (fun f ->
                  Ezxmlm.make_tag "SerialNumber" ([], (String.to_xml f)))])
           @
           [Util.option_map v.token_code
              (fun f -> Ezxmlm.make_tag "TokenCode" ([], (String.to_xml f)))])
  end
module GetSessionTokenResponse = GetSessionTokenResponse
type input = GetSessionTokenRequest.t
type output = GetSessionTokenResponse.t
type error = Errors_internal.t
let streaming = false
let service = "sts"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-06-15"]); ("Action", ["GetSessionToken"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetSessionTokenRequest.to_query req))))) in
  (`POST, uri, (Headers.render (GetSessionTokenRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetSessionTokenResponse" (snd xml))
        (Xml.member "GetSessionTokenResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetSessionTokenResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetSessionTokenResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetSessionTokenResponse - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None