open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteDBParameterGroupMessage =
  struct
    type t =
      {
      d_b_parameter_group_name: String.t
        [@ocaml.doc
          "<p>The name of the DB parameter group.</p> <p>Constraints:</p> <ul> <li> <p>Must be the name of an existing DB parameter group</p> </li> <li> <p>You can't delete a default DB parameter group</p> </li> <li> <p>Can't be associated with any DB instances</p> </li> </ul>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_parameter_group_name  () = { d_b_parameter_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_parameter_group_name",
                (String.to_json v.d_b_parameter_group_name))])
    let parse xml =
      Some
        {
          d_b_parameter_group_name =
            (Xml.required "DBParameterGroupName"
               (Util.option_bind (Xml.member "DBParameterGroupName" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "DBParameterGroupName"
                 ([], (String.to_xml v.d_b_parameter_group_name)))])
  end[@@ocaml.doc "<p/>"]
module Output = Aws.BaseTypes.Unit
type input = DeleteDBParameterGroupMessage.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["DeleteDBParameterGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteDBParameterGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteDBParameterGroupMessage.to_headers req)), "")
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