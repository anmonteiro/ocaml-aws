open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyNetworkInterfaceAttributeRequest =
  struct
    type t =
      {
      attachment: NetworkInterfaceAttachmentChanges.t option
        [@ocaml.doc
          "<p>Information about the interface attachment. If modifying the 'delete on termination' attribute, you must specify the ID of the interface attachment.</p>"];
      description: AttributeValue.t option
        [@ocaml.doc "<p>A description for the network interface.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      groups: SecurityGroupIdStringList.t
        [@ocaml.doc
          "<p>Changes the security groups for the network interface. The new set of groups you specify replaces the current set. You must specify at least one group, even if it's just the default security group in the VPC. You must specify the ID of the security group, not the name.</p>"];
      network_interface_id: String.t
        [@ocaml.doc "<p>The ID of the network interface.</p>"];
      source_dest_check: AttributeBooleanValue.t option
        [@ocaml.doc
          "<p>Indicates whether source/destination checking is enabled. A value of <code>true</code> means checking is enabled, and <code>false</code> means checking is disabled. This value must be <code>false</code> for a NAT instance to perform NAT. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_NAT_Instance.html\">NAT Instances</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for ModifyNetworkInterfaceAttribute.</p>"]
    let make ?attachment  ?description  ?dry_run  ?(groups= []) 
      ~network_interface_id  ?source_dest_check  () =
      {
        attachment;
        description;
        dry_run;
        groups;
        network_interface_id;
        source_dest_check
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.source_dest_check
              (fun f ->
                 Query.Pair
                   ("SourceDestCheck", (AttributeBooleanValue.to_query f)));
           Some
             (Query.Pair
                ("NetworkInterfaceId",
                  (String.to_query v.network_interface_id)));
           Some
             (Query.Pair
                ("SecurityGroupId",
                  (SecurityGroupIdStringList.to_query v.groups)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f ->
                Query.Pair ("Description", (AttributeValue.to_query f)));
           Util.option_map v.attachment
             (fun f ->
                Query.Pair
                  ("Attachment",
                    (NetworkInterfaceAttachmentChanges.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.source_dest_check
              (fun f ->
                 ("source_dest_check", (AttributeBooleanValue.to_json f)));
           Some
             ("network_interface_id",
               (String.to_json v.network_interface_id));
           Some ("groups", (SecurityGroupIdStringList.to_json v.groups));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (AttributeValue.to_json f)));
           Util.option_map v.attachment
             (fun f ->
                ("attachment", (NetworkInterfaceAttachmentChanges.to_json f)))])
    let parse xml =
      Some
        {
          attachment =
            (Util.option_bind (Xml.member "attachment" xml)
               NetworkInterfaceAttachmentChanges.parse);
          description =
            (Util.option_bind (Xml.member "description" xml)
               AttributeValue.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "SecurityGroupId" xml)
                  SecurityGroupIdStringList.parse));
          network_interface_id =
            (Xml.required "networkInterfaceId"
               (Util.option_bind (Xml.member "networkInterfaceId" xml)
                  String.parse));
          source_dest_check =
            (Util.option_bind (Xml.member "sourceDestCheck" xml)
               AttributeBooleanValue.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.attachment
                   (fun f ->
                      Ezxmlm.make_tag "attachment"
                        ([], (NetworkInterfaceAttachmentChanges.to_xml f)))])
               @
               [Util.option_map v.description
                  (fun f ->
                     Ezxmlm.make_tag "description"
                       ([], (AttributeValue.to_xml f)))])
              @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "SecurityGroupId"
                        ([], (SecurityGroupIdStringList.to_xml [x]))))
                v.groups))
            @
            [Some
               (Ezxmlm.make_tag "networkInterfaceId"
                  ([], (String.to_xml v.network_interface_id)))])
           @
           [Util.option_map v.source_dest_check
              (fun f ->
                 Ezxmlm.make_tag "sourceDestCheck"
                   ([], (AttributeBooleanValue.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for ModifyNetworkInterfaceAttribute.</p>"]
module Output = Aws.BaseTypes.Unit
type input = ModifyNetworkInterfaceAttributeRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["ModifyNetworkInterfaceAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyNetworkInterfaceAttributeRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyNetworkInterfaceAttributeRequest.to_headers req)),
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