open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RemoveRoleFromDBInstanceMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The name of the DB instance to disassociate the IAM role from.</p>"];
      role_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM role to disassociate from the DB instance, for example <code>arn:aws:iam::123456789012:role/AccessRole</code>.</p>"];
      feature_name: String.t
        [@ocaml.doc
          "<p>The name of the feature for the DB instance that the IAM role is to be disassociated from. For the list of supported feature names, see <code>DBEngineVersion</code>. </p>"]}
    let make ~d_b_instance_identifier  ~role_arn  ~feature_name  () =
      { d_b_instance_identifier; role_arn; feature_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("feature_name", (String.to_json v.feature_name));
           Some ("role_arn", (String.to_json v.role_arn));
           Some
             ("d_b_instance_identifier",
               (String.to_json v.d_b_instance_identifier))])
    let parse xml =
      Some
        {
          d_b_instance_identifier =
            (Xml.required "DBInstanceIdentifier"
               (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
                  String.parse));
          role_arn =
            (Xml.required "RoleArn"
               (Util.option_bind (Xml.member "RoleArn" xml) String.parse));
          feature_name =
            (Xml.required "FeatureName"
               (Util.option_bind (Xml.member "FeatureName" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBInstanceIdentifier"
                   ([], (String.to_xml v.d_b_instance_identifier)))])
            @
            [Some
               (Ezxmlm.make_tag "RoleArn" ([], (String.to_xml v.role_arn)))])
           @
           [Some
              (Ezxmlm.make_tag "FeatureName"
                 ([], (String.to_xml v.feature_name)))])
  end
module Output = Aws.BaseTypes.Unit
type input = RemoveRoleFromDBInstanceMessage.t
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
         ("Action", ["RemoveRoleFromDBInstance"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RemoveRoleFromDBInstanceMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (RemoveRoleFromDBInstanceMessage.to_headers req)), "")
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