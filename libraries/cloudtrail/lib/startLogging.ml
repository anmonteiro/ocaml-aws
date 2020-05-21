open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StartLoggingRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>Specifies the name or the CloudTrail ARN of the trail for which CloudTrail logs AWS API calls. The format of a trail ARN is:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"]}
    [@@ocaml.doc
      "<p>The request to CloudTrail to start logging AWS API calls for an account.</p>"]
    let make ~name  () = { name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("name", (String.to_json v.name))])
    let of_json j =
      { name = (String.of_json (Util.of_option_exn (Json.lookup j "name"))) }
  end[@@ocaml.doc
       "<p>The request to CloudTrail to start logging AWS API calls for an account.</p>"]
module Output = Aws.BaseTypes.Unit
type input = StartLoggingRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "cloudtrail"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (StartLoggingRequest.to_query req)))) in
  (`POST, uri, (Headers.render (StartLoggingRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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