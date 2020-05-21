open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module Input = Aws.BaseTypes.Unit
module DescribeLifecycleHookTypesAnswer = DescribeLifecycleHookTypesAnswer
type input = Aws.BaseTypes.Unit.t
type output = DescribeLifecycleHookTypesAnswer.t
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]);
         ("Action", ["DescribeLifecycleHookTypes"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (Aws.BaseTypes.Unit.to_query req))))) in
  (`POST, uri, (Headers.render (Aws.BaseTypes.Unit.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeLifecycleHookTypesResponse" (snd xml))
        (Xml.member "DescribeLifecycleHookTypesResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeLifecycleHookTypesAnswer.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeLifecycleHookTypesAnswer."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeLifecycleHookTypesAnswer - missing field in body or children: "
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