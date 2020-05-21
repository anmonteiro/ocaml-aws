open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeInstancePatchStatesForPatchGroupRequest =
  struct
    type t =
      {
      patch_group: String.t
        [@ocaml.doc
          "<p>The name of the patch group for which the patch state information should be retrieved.</p>"];
      filters: InstancePatchStateFilterList.t
        [@ocaml.doc
          "<p>Each entry in the array is a structure containing:</p> <p>Key (string between 1 and 200 characters)</p> <p> Values (array containing a single string)</p> <p> Type (string \"Equal\", \"NotEqual\", \"LessThan\", \"GreaterThan\")</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of patches to return (per page).</p>"]}
    let make ~patch_group  ?(filters= [])  ?next_token  ?max_results  () =
      { patch_group; filters; next_token; max_results }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("filters", (InstancePatchStateFilterList.to_json v.filters));
           Some ("patch_group", (String.to_json v.patch_group))])
    let of_json j =
      {
        patch_group =
          (String.of_json (Util.of_option_exn (Json.lookup j "patch_group")));
        filters =
          (InstancePatchStateFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json)
      }
  end
module DescribeInstancePatchStatesForPatchGroupResult =
  DescribeInstancePatchStatesForPatchGroupResult
type input = DescribeInstancePatchStatesForPatchGroupRequest.t
type output = DescribeInstancePatchStatesForPatchGroupResult.t
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
            (Query.render
               (DescribeInstancePatchStatesForPatchGroupRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render
       (DescribeInstancePatchStatesForPatchGroupRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribeInstancePatchStatesForPatchGroupResult.of_json json)
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