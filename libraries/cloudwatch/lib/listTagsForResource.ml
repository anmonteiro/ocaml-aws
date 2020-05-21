open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListTagsForResourceInput =
  struct
    type t =
      {
      resource_a_r_n: String.t
        [@ocaml.doc
          "<p>The ARN of the CloudWatch resource that you want to view tags for. For more information on ARN format, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-cloudwatch\">Example ARNs</a> in the <i>Amazon Web Services General Reference</i>.</p>"]}
    let make ~resource_a_r_n  () = { resource_a_r_n }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("resource_a_r_n", (String.to_json v.resource_a_r_n))])
    let parse xml =
      Some
        {
          resource_a_r_n =
            (Xml.required "ResourceARN"
               (Util.option_bind (Xml.member "ResourceARN" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ResourceARN"
                 ([], (String.to_xml v.resource_a_r_n)))])
  end
module ListTagsForResourceOutput = ListTagsForResourceOutput
type input = ListTagsForResourceInput.t
type output = ListTagsForResourceOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["ListTagsForResource"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListTagsForResourceInput.to_query req))))) in
  (`POST, uri, (Headers.render (ListTagsForResourceInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListTagsForResourceResponse" (snd xml))
        (Xml.member "ListTagsForResourceResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListTagsForResourceOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListTagsForResourceOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListTagsForResourceOutput - missing field in body or children: "
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