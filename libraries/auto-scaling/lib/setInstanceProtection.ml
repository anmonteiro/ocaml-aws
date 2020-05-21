open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SetInstanceProtectionQuery =
  struct
    type t =
      {
      instance_ids: InstanceIds.t
        [@ocaml.doc "<p>One or more instance IDs.</p>"];
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      protected_from_scale_in: Boolean.t
        [@ocaml.doc
          "<p>Indicates whether the instance is protected from termination by Amazon EC2 Auto Scaling when scaling in.</p>"]}
    let make ~instance_ids  ~auto_scaling_group_name 
      ~protected_from_scale_in  () =
      { instance_ids; auto_scaling_group_name; protected_from_scale_in }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("protected_from_scale_in",
                (Boolean.to_json v.protected_from_scale_in));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name));
           Some ("instance_ids", (InstanceIds.to_json v.instance_ids))])
    let parse xml =
      Some
        {
          instance_ids =
            (Xml.required "InstanceIds"
               (Util.option_bind (Xml.member "InstanceIds" xml)
                  InstanceIds.parse));
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          protected_from_scale_in =
            (Xml.required "ProtectedFromScaleIn"
               (Util.option_bind (Xml.member "ProtectedFromScaleIn" xml)
                  Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "InstanceIds"
                        ([], (InstanceIds.to_xml [x])))) v.instance_ids))
            @
            [Some
               (Ezxmlm.make_tag "AutoScalingGroupName"
                  ([], (String.to_xml v.auto_scaling_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "ProtectedFromScaleIn"
                 ([], (Boolean.to_xml v.protected_from_scale_in)))])
  end
module Output = Aws.BaseTypes.Unit
type input = SetInstanceProtectionQuery.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]); ("Action", ["SetInstanceProtection"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (SetInstanceProtectionQuery.to_query req))))) in
  (`POST, uri, (Headers.render (SetInstanceProtectionQuery.to_headers req)),
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