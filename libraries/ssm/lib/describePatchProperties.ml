open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribePatchPropertiesRequest =
  struct
    type t =
      {
      operating_system: OperatingSystem.t
        [@ocaml.doc
          "<p>The operating system type for which to list patches.</p>"];
      property: PatchProperty.t
        [@ocaml.doc
          "<p>The patch property for which you want to view patch details. </p>"];
      patch_set: PatchSet.t option
        [@ocaml.doc
          "<p>Indicates whether to list patches for the Windows operating system or for Microsoft applications. Not applicable for Linux operating systems.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"]}
    let make ~operating_system  ~property  ?patch_set  ?max_results 
      ?next_token  () =
      { operating_system; property; patch_set; max_results; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.patch_set
             (fun f -> ("patch_set", (PatchSet.to_json f)));
           Some ("property", (PatchProperty.to_json v.property));
           Some
             ("operating_system",
               (OperatingSystem.to_json v.operating_system))])
    let of_json j =
      {
        operating_system =
          (OperatingSystem.of_json
             (Util.of_option_exn (Json.lookup j "operating_system")));
        property =
          (PatchProperty.of_json
             (Util.of_option_exn (Json.lookup j "property")));
        patch_set =
          (Util.option_map (Json.lookup j "patch_set") PatchSet.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribePatchPropertiesResult = DescribePatchPropertiesResult
type input = DescribePatchPropertiesRequest.t
type output = DescribePatchPropertiesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (DescribePatchPropertiesRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (DescribePatchPropertiesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribePatchPropertiesResult.of_json json)
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