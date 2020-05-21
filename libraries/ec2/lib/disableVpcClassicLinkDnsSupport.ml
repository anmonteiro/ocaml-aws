open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DisableVpcClassicLinkDnsSupportRequest =
  struct
    type t =
      {
      vpc_id: String.t option [@ocaml.doc "<p>The ID of the VPC.</p>"]}
    let make ?vpc_id  () = { vpc_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.vpc_id
              (fun f -> Query.Pair ("VpcId", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.vpc_id
              (fun f -> ("vpc_id", (String.to_json f)))])
    let parse xml =
      Some
        { vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.vpc_id
              (fun f -> Ezxmlm.make_tag "VpcId" ([], (String.to_xml f)))])
  end
module DisableVpcClassicLinkDnsSupportResult =
  DisableVpcClassicLinkDnsSupportResult
type input = DisableVpcClassicLinkDnsSupportRequest.t
type output = DisableVpcClassicLinkDnsSupportResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["DisableVpcClassicLinkDnsSupport"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DisableVpcClassicLinkDnsSupportRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DisableVpcClassicLinkDnsSupportRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DisableVpcClassicLinkDnsSupportResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DisableVpcClassicLinkDnsSupportResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DisableVpcClassicLinkDnsSupportResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DisableVpcClassicLinkDnsSupportResult - missing field in body or children: "
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