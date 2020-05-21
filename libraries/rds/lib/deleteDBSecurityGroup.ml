open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteDBSecurityGroupMessage =
  struct
    type t =
      {
      d_b_security_group_name: String.t
        [@ocaml.doc
          "<p>The name of the DB security group to delete.</p> <note> <p>You can't delete the default DB security group.</p> </note> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> <li> <p>Must not be \"Default\"</p> </li> </ul>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_security_group_name  () = { d_b_security_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_security_group_name",
                (String.to_json v.d_b_security_group_name))])
    let parse xml =
      Some
        {
          d_b_security_group_name =
            (Xml.required "DBSecurityGroupName"
               (Util.option_bind (Xml.member "DBSecurityGroupName" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "DBSecurityGroupName"
                 ([], (String.to_xml v.d_b_security_group_name)))])
  end[@@ocaml.doc "<p/>"]
module Output = Aws.BaseTypes.Unit
type input = DeleteDBSecurityGroupMessage.t
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
         [("Version", ["2014-10-31"]); ("Action", ["DeleteDBSecurityGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteDBSecurityGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteDBSecurityGroupMessage.to_headers req)), "")
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