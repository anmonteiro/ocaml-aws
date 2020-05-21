open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeregisterDBProxyTargetsRequest =
  struct
    type t =
      {
      d_b_proxy_name: String.t
        [@ocaml.doc
          "<p>The identifier of the <code>DBProxy</code> that is associated with the <code>DBProxyTargetGroup</code>.</p>"];
      target_group_name: String.t option
        [@ocaml.doc
          "<p>The identifier of the <code>DBProxyTargetGroup</code>.</p>"];
      d_b_instance_identifiers: StringList.t
        [@ocaml.doc "<p>One or more DB instance identifiers.</p>"];
      d_b_cluster_identifiers: StringList.t
        [@ocaml.doc "<p>One or more DB cluster identifiers.</p>"]}
    let make ~d_b_proxy_name  ?target_group_name  ?(d_b_instance_identifiers=
      [])  ?(d_b_cluster_identifiers= [])  () =
      {
        d_b_proxy_name;
        target_group_name;
        d_b_instance_identifiers;
        d_b_cluster_identifiers
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_cluster_identifiers",
                (StringList.to_json v.d_b_cluster_identifiers));
           Some
             ("d_b_instance_identifiers",
               (StringList.to_json v.d_b_instance_identifiers));
           Util.option_map v.target_group_name
             (fun f -> ("target_group_name", (String.to_json f)));
           Some ("d_b_proxy_name", (String.to_json v.d_b_proxy_name))])
    let parse xml =
      Some
        {
          d_b_proxy_name =
            (Xml.required "DBProxyName"
               (Util.option_bind (Xml.member "DBProxyName" xml) String.parse));
          target_group_name =
            (Util.option_bind (Xml.member "TargetGroupName" xml) String.parse);
          d_b_instance_identifiers =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBInstanceIdentifiers" xml)
                  StringList.parse));
          d_b_cluster_identifiers =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBClusterIdentifiers" xml)
                  StringList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DBProxyName"
                    ([], (String.to_xml v.d_b_proxy_name)))])
             @
             [Util.option_map v.target_group_name
                (fun f ->
                   Ezxmlm.make_tag "TargetGroupName" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "DBInstanceIdentifiers"
                       ([], (StringList.to_xml [x]))))
               v.d_b_instance_identifiers))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBClusterIdentifiers"
                      ([], (StringList.to_xml [x]))))
              v.d_b_cluster_identifiers))
  end
module Output = Aws.BaseTypes.Unit
type input = DeregisterDBProxyTargetsRequest.t
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
         ("Action", ["DeregisterDBProxyTargets"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeregisterDBProxyTargetsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeregisterDBProxyTargetsRequest.to_headers req)), "")
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