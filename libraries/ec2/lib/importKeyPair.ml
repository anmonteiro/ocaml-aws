open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ImportKeyPairRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      key_name: String.t
        [@ocaml.doc "<p>A unique name for the key pair.</p>"];
      public_key_material: Blob.t
        [@ocaml.doc
          "<p>The public key. For API calls, the text must be base64-encoded. For command line tools, base64 encoding is performed for you.</p>"]}
    let make ?dry_run  ~key_name  ~public_key_material  () =
      { dry_run; key_name; public_key_material }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("PublicKeyMaterial", (Blob.to_query v.public_key_material)));
           Some (Query.Pair ("KeyName", (String.to_query v.key_name)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("public_key_material", (Blob.to_json v.public_key_material));
           Some ("key_name", (String.to_json v.key_name));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          key_name =
            (Xml.required "keyName"
               (Util.option_bind (Xml.member "keyName" xml) String.parse));
          public_key_material =
            (Xml.required "publicKeyMaterial"
               (Util.option_bind (Xml.member "publicKeyMaterial" xml)
                  Blob.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "keyName" ([], (String.to_xml v.key_name)))])
           @
           [Some
              (Ezxmlm.make_tag "publicKeyMaterial"
                 ([], (Blob.to_xml v.public_key_material)))])
  end
module ImportKeyPairResult = ImportKeyPairResult
type input = ImportKeyPairRequest.t
type output = ImportKeyPairResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ImportKeyPair"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ImportKeyPairRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ImportKeyPairRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ImportKeyPairResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ImportKeyPairResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ImportKeyPairResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ImportKeyPairResult - missing field in body or children: "
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