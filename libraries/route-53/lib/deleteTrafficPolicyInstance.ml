open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteTrafficPolicyInstanceRequest =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID of the traffic policy instance that you want to delete. </p> <important> <p>When you delete a traffic policy instance, Amazon Route 53 also deletes all of the resource record sets that were created when you created the traffic policy instance.</p> </important>"]}
    [@@ocaml.doc
      "<p>A request to delete a specified traffic policy instance.</p>"]
    let make ~id  () = { id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
  end[@@ocaml.doc
       "<p>A request to delete a specified traffic policy instance.</p>"]
module Output = Aws.BaseTypes.Unit
type input = DeleteTrafficPolicyInstanceRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/2013-04-01/trafficpolicyinstance/" ^
               req.DeleteTrafficPolicyInstanceRequest.id)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (DeleteTrafficPolicyInstanceRequest.to_query req)))) in
  (`DELETE, uri,
    (Headers.render (DeleteTrafficPolicyInstanceRequest.to_headers req)), "")
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