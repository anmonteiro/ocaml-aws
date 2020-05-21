open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeAssociationRequest =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>The name of the Systems Manager document.</p>"];
      instance_id: String.t option [@ocaml.doc "<p>The instance ID.</p>"];
      association_id: String.t option
        [@ocaml.doc
          "<p>The association ID for which you want information.</p>"];
      association_version: String.t option
        [@ocaml.doc
          "<p>Specify the association version to retrieve. To view the latest version, either specify <code>$LATEST</code> for this parameter, or omit this parameter. To view a list of all associations for an instance, use <a>ListAssociations</a>. To get a list of versions for a specific association, use <a>ListAssociationVersions</a>. </p>"]}
    let make ?name  ?instance_id  ?association_id  ?association_version  () =
      { name; instance_id; association_id; association_version }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_version
              (fun f -> ("association_version", (String.to_json f)));
           Util.option_map v.association_id
             (fun f -> ("association_id", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        association_id =
          (Util.option_map (Json.lookup j "association_id") String.of_json);
        association_version =
          (Util.option_map (Json.lookup j "association_version")
             String.of_json)
      }
  end
module DescribeAssociationResult = DescribeAssociationResult
type input = DescribeAssociationRequest.t
type output = DescribeAssociationResult.t
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
            (Query.render (DescribeAssociationRequest.to_query req)))) in
  (`POST, uri, (Headers.render (DescribeAssociationRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribeAssociationResult.of_json json)
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