open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutEventSelectorsRequest =
  struct
    type t =
      {
      trail_name: String.t
        [@ocaml.doc
          "<p>Specifies the name of the trail or trail ARN. If you specify a trail name, the string must meet the following requirements:</p> <ul> <li> <p>Contain only ASCII letters (a-z, A-Z), numbers (0-9), periods (.), underscores (_), or dashes (-)</p> </li> <li> <p>Start with a letter or number, and end with a letter or number</p> </li> <li> <p>Be between 3 and 128 characters</p> </li> <li> <p>Have no adjacent periods, underscores or dashes. Names like <code>my-_namespace</code> and <code>my--namespace</code> are invalid.</p> </li> <li> <p>Not be in IP address format (for example, 192.168.5.4)</p> </li> </ul> <p>If you specify a trail ARN, it must be in the format:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"];
      event_selectors: EventSelectors.t
        [@ocaml.doc
          "<p>Specifies the settings for your event selectors. You can configure up to five event selectors for a trail.</p>"]}
    let make ~trail_name  ~event_selectors  () =
      { trail_name; event_selectors }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("event_selectors", (EventSelectors.to_json v.event_selectors));
           Some ("trail_name", (String.to_json v.trail_name))])
    let of_json j =
      {
        trail_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "trail_name")));
        event_selectors =
          (EventSelectors.of_json
             (Util.of_option_exn (Json.lookup j "event_selectors")))
      }
  end
module PutEventSelectorsResponse = PutEventSelectorsResponse
type input = PutEventSelectorsRequest.t
type output = PutEventSelectorsResponse.t
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
            (Query.render (PutEventSelectorsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (PutEventSelectorsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (PutEventSelectorsResponse.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
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