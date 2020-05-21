open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTrafficPolicyRequest =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "<p>The name of the traffic policy.</p>"];
      document: String.t
        [@ocaml.doc
          "<p>The definition of this traffic policy in JSON format. For more information, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/api-policies-traffic-policy-document-format.html\">Traffic Policy Document Format</a>.</p>"];
      comment: String.t option
        [@ocaml.doc
          "<p>(Optional) Any comments that you want to include about the traffic policy.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the traffic policy that you want to create.</p>"]
    let make ~name  ~document  ?comment  () = { name; document; comment }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.comment
              (fun f -> ("comment", (String.to_json f)));
           Some ("document", (String.to_json v.document));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          document =
            (Xml.required "Document"
               (Util.option_bind (Xml.member "Document" xml) String.parse));
          comment =
            (Util.option_bind (Xml.member "Comment" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
            @
            [Some
               (Ezxmlm.make_tag "Document" ([], (String.to_xml v.document)))])
           @
           [Util.option_map v.comment
              (fun f -> Ezxmlm.make_tag "Comment" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the traffic policy that you want to create.</p>"]
module CreateTrafficPolicyResponse = CreateTrafficPolicyResponse
type input = CreateTrafficPolicyRequest.t
type output = CreateTrafficPolicyResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/trafficpolicy"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CreateTrafficPolicyRequest.to_query req)))) in
  (`POST, uri, (Headers.render (CreateTrafficPolicyRequest.to_headers req)),
    "")
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
               "Could not find well formed CreateTrafficPolicyResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateTrafficPolicyResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTrafficPolicyResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTrafficPolicyResponse - missing field in body or children: "
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