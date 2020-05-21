open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTrafficPolicyVersionRequest =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID of the traffic policy for which you want to create a new version.</p>"];
      document: String.t
        [@ocaml.doc
          "<p>The definition of this version of the traffic policy, in JSON format. You specified the JSON in the <code>CreateTrafficPolicyVersion</code> request. For more information about the JSON format, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateTrafficPolicy.html\">CreateTrafficPolicy</a>.</p>"];
      comment: String.t option
        [@ocaml.doc
          "<p>The comment that you specified in the <code>CreateTrafficPolicyVersion</code> request, if any.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the traffic policy that you want to create a new version for.</p>"]
    let make ~id  ~document  ?comment  () = { id; document; comment }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.comment
              (fun f -> ("comment", (String.to_json f)));
           Some ("document", (String.to_json v.document));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          document =
            (Xml.required "Document"
               (Util.option_bind (Xml.member "Document" xml) String.parse));
          comment =
            (Util.option_bind (Xml.member "Comment" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
            [Some
               (Ezxmlm.make_tag "Document" ([], (String.to_xml v.document)))])
           @
           [Util.option_map v.comment
              (fun f -> Ezxmlm.make_tag "Comment" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the traffic policy that you want to create a new version for.</p>"]
module CreateTrafficPolicyVersionResponse =
  CreateTrafficPolicyVersionResponse
type input = CreateTrafficPolicyVersionRequest.t
type output = CreateTrafficPolicyVersionResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/2013-04-01/trafficpolicy/" ^
               req.CreateTrafficPolicyVersionRequest.id)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CreateTrafficPolicyVersionRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (CreateTrafficPolicyVersionRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure
               "Could not find well formed CreateTrafficPolicyVersionResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateTrafficPolicyVersionResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTrafficPolicyVersionResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTrafficPolicyVersionResponse - missing field in body or children: "
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