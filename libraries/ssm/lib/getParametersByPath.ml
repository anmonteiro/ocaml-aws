open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetParametersByPathRequest =
  struct
    type t =
      {
      path: String.t
        [@ocaml.doc
          "<p>The hierarchy for the parameter. Hierarchies start with a forward slash (/) and end with the parameter name. A parameter name hierarchy can have a maximum of 15 levels. Here is an example of a hierarchy: <code>/Finance/Prod/IAD/WinServ2016/license33</code> </p>"];
      recursive: Boolean.t option
        [@ocaml.doc
          "<p>Retrieve all parameters within a hierarchy.</p> <important> <p>If a user has access to a path, then the user can access all levels of that path. For example, if a user has permission to access path <code>/a</code>, then the user can also access <code>/a/b</code>. Even if a user has explicitly been denied access in IAM for parameter <code>/a/b</code>, they can still call the GetParametersByPath API action recursively for <code>/a</code> and view <code>/a/b</code>.</p> </important>"];
      parameter_filters: ParameterStringFilterList.t
        [@ocaml.doc "<p>Filters to limit the request results.</p>"];
      with_decryption: Boolean.t option
        [@ocaml.doc
          "<p>Retrieve all parameters in a hierarchy with their value decrypted.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A token to start the list. Use this token to get the next set of results. </p>"]}
    let make ~path  ?recursive  ?(parameter_filters= [])  ?with_decryption 
      ?max_results  ?next_token  () =
      {
        path;
        recursive;
        parameter_filters;
        with_decryption;
        max_results;
        next_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.with_decryption
             (fun f -> ("with_decryption", (Boolean.to_json f)));
           Some
             ("parameter_filters",
               (ParameterStringFilterList.to_json v.parameter_filters));
           Util.option_map v.recursive
             (fun f -> ("recursive", (Boolean.to_json f)));
           Some ("path", (String.to_json v.path))])
    let of_json j =
      {
        path = (String.of_json (Util.of_option_exn (Json.lookup j "path")));
        recursive =
          (Util.option_map (Json.lookup j "recursive") Boolean.of_json);
        parameter_filters =
          (ParameterStringFilterList.of_json
             (Util.of_option_exn (Json.lookup j "parameter_filters")));
        with_decryption =
          (Util.option_map (Json.lookup j "with_decryption") Boolean.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetParametersByPathResult = GetParametersByPathResult
type input = GetParametersByPathRequest.t
type output = GetParametersByPathResult.t
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
            (Query.render (GetParametersByPathRequest.to_query req)))) in
  (`POST, uri, (Headers.render (GetParametersByPathRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (GetParametersByPathResult.of_json json)
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