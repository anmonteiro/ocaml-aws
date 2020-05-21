open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateAssociationStatusRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc "<p>The name of the Systems Manager document.</p>"];
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      association_status: AssociationStatus.t
        [@ocaml.doc "<p>The association status.</p>"]}
    let make ~name  ~instance_id  ~association_status  () =
      { name; instance_id; association_status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("association_status",
                (AssociationStatus.to_json v.association_status));
           Some ("instance_id", (String.to_json v.instance_id));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        instance_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "instance_id")));
        association_status =
          (AssociationStatus.of_json
             (Util.of_option_exn (Json.lookup j "association_status")))
      }
  end
module UpdateAssociationStatusResult = UpdateAssociationStatusResult
type input = UpdateAssociationStatusRequest.t
type output = UpdateAssociationStatusResult.t
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
            (Query.render (UpdateAssociationStatusRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (UpdateAssociationStatusRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (UpdateAssociationStatusResult.of_json json)
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