open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RemoveRoleFromDBClusterMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The name of the DB cluster to disassociate the IAM role from.</p>"];
      role_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM role to disassociate from the Aurora DB cluster, for example <code>arn:aws:iam::123456789012:role/AuroraAccessRole</code>.</p>"];
      feature_name: String.t option
        [@ocaml.doc
          "<p>The name of the feature for the DB cluster that the IAM role is to be disassociated from. For the list of supported feature names, see <a>DBEngineVersion</a>.</p>"]}
    let make ~d_b_cluster_identifier  ~role_arn  ?feature_name  () =
      { d_b_cluster_identifier; role_arn; feature_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.feature_name
              (fun f -> ("feature_name", (String.to_json f)));
           Some ("role_arn", (String.to_json v.role_arn));
           Some
             ("d_b_cluster_identifier",
               (String.to_json v.d_b_cluster_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse));
          role_arn =
            (Xml.required "RoleArn"
               (Util.option_bind (Xml.member "RoleArn" xml) String.parse));
          feature_name =
            (Util.option_bind (Xml.member "FeatureName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBClusterIdentifier"
                   ([], (String.to_xml v.d_b_cluster_identifier)))])
            @
            [Some
               (Ezxmlm.make_tag "RoleArn" ([], (String.to_xml v.role_arn)))])
           @
           [Util.option_map v.feature_name
              (fun f -> Ezxmlm.make_tag "FeatureName" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = RemoveRoleFromDBClusterMessage.t
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
         ("Action", ["RemoveRoleFromDBCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RemoveRoleFromDBClusterMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (RemoveRoleFromDBClusterMessage.to_headers req)), "")
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