open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteAssociationRequest =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>The name of the Systems Manager document.</p>"];
      instance_id: String.t option
        [@ocaml.doc "<p>The ID of the instance.</p>"];
      association_id: String.t option
        [@ocaml.doc "<p>The association ID that you want to delete.</p>"]}
    let make ?name  ?instance_id  ?association_id  () =
      { name; instance_id; association_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_id
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
          (Util.option_map (Json.lookup j "association_id") String.of_json)
      }
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteAssociationRequest.t
type output = unit
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
            (Query.render (DeleteAssociationRequest.to_query req)))) in
  (`POST, uri, (Headers.render (DeleteAssociationRequest.to_headers req)),
    "")
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