open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateManagedInstanceRoleRequest =
  struct
    type t =
      {
      instance_id: String.t
        [@ocaml.doc
          "<p>The ID of the managed instance where you want to update the role.</p>"];
      iam_role: String.t
        [@ocaml.doc "<p>The IAM role you want to assign or change.</p>"]}
    let make ~instance_id  ~iam_role  () = { instance_id; iam_role }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("iam_role", (String.to_json v.iam_role));
           Some ("instance_id", (String.to_json v.instance_id))])
    let of_json j =
      {
        instance_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "instance_id")));
        iam_role =
          (String.of_json (Util.of_option_exn (Json.lookup j "iam_role")))
      }
  end
module Output = Aws.BaseTypes.Unit
type input = UpdateManagedInstanceRoleRequest.t
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
            (Query.render (UpdateManagedInstanceRoleRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (UpdateManagedInstanceRoleRequest.to_headers req)), "")
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