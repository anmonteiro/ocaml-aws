open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StartAssociationsOnceRequest =
  struct
    type t =
      {
      association_ids: AssociationIdList.t
        [@ocaml.doc
          "<p>The association IDs that you want to run immediately and only one time.</p>"]}
    let make ~association_ids  () = { association_ids }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("association_ids",
                (AssociationIdList.to_json v.association_ids))])
    let of_json j =
      {
        association_ids =
          (AssociationIdList.of_json
             (Util.of_option_exn (Json.lookup j "association_ids")))
      }
  end
module Output = Aws.BaseTypes.Unit
type input = StartAssociationsOnceRequest.t
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
            (Query.render (StartAssociationsOnceRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (StartAssociationsOnceRequest.to_headers req)), "")
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