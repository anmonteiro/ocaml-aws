open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyInstancePlacementRequest =
  struct
    type t =
      {
      affinity: Affinity.t option
        [@ocaml.doc "<p>The affinity setting for the instance.</p>"];
      group_name: String.t option
        [@ocaml.doc
          "<p>The name of the placement group in which to place the instance. For spread placement groups, the instance must have a tenancy of <code>default</code>. For cluster and partition placement groups, the instance must have a tenancy of <code>default</code> or <code>dedicated</code>.</p> <p>To remove an instance from a placement group, specify an empty string (\"\").</p>"];
      host_id: String.t option
        [@ocaml.doc
          "<p>The ID of the Dedicated Host with which to associate the instance.</p>"];
      instance_id: String.t
        [@ocaml.doc "<p>The ID of the instance that you are modifying.</p>"];
      tenancy: HostTenancy.t option
        [@ocaml.doc "<p>The tenancy for the instance.</p>"];
      partition_number: Integer.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"];
      host_resource_group_arn: String.t option
        [@ocaml.doc
          "<p>The ARN of the host resource group in which to place the instance.</p>"]}
    let make ?affinity  ?group_name  ?host_id  ~instance_id  ?tenancy 
      ?partition_number  ?host_resource_group_arn  () =
      {
        affinity;
        group_name;
        host_id;
        instance_id;
        tenancy;
        partition_number;
        host_resource_group_arn
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.host_resource_group_arn
              (fun f ->
                 Query.Pair ("HostResourceGroupArn", (String.to_query f)));
           Util.option_map v.partition_number
             (fun f -> Query.Pair ("PartitionNumber", (Integer.to_query f)));
           Util.option_map v.tenancy
             (fun f -> Query.Pair ("Tenancy", (HostTenancy.to_query f)));
           Some (Query.Pair ("InstanceId", (String.to_query v.instance_id)));
           Util.option_map v.host_id
             (fun f -> Query.Pair ("HostId", (String.to_query f)));
           Util.option_map v.group_name
             (fun f -> Query.Pair ("GroupName", (String.to_query f)));
           Util.option_map v.affinity
             (fun f -> Query.Pair ("Affinity", (Affinity.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.host_resource_group_arn
              (fun f -> ("host_resource_group_arn", (String.to_json f)));
           Util.option_map v.partition_number
             (fun f -> ("partition_number", (Integer.to_json f)));
           Util.option_map v.tenancy
             (fun f -> ("tenancy", (HostTenancy.to_json f)));
           Some ("instance_id", (String.to_json v.instance_id));
           Util.option_map v.host_id
             (fun f -> ("host_id", (String.to_json f)));
           Util.option_map v.group_name
             (fun f -> ("group_name", (String.to_json f)));
           Util.option_map v.affinity
             (fun f -> ("affinity", (Affinity.to_json f)))])
    let parse xml =
      Some
        {
          affinity =
            (Util.option_bind (Xml.member "affinity" xml) Affinity.parse);
          group_name =
            (Util.option_bind (Xml.member "GroupName" xml) String.parse);
          host_id = (Util.option_bind (Xml.member "hostId" xml) String.parse);
          instance_id =
            (Xml.required "instanceId"
               (Util.option_bind (Xml.member "instanceId" xml) String.parse));
          tenancy =
            (Util.option_bind (Xml.member "tenancy" xml) HostTenancy.parse);
          partition_number =
            (Util.option_bind (Xml.member "PartitionNumber" xml)
               Integer.parse);
          host_resource_group_arn =
            (Util.option_bind (Xml.member "HostResourceGroupArn" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.affinity
                    (fun f ->
                       Ezxmlm.make_tag "affinity" ([], (Affinity.to_xml f)))])
                @
                [Util.option_map v.group_name
                   (fun f ->
                      Ezxmlm.make_tag "GroupName" ([], (String.to_xml f)))])
               @
               [Util.option_map v.host_id
                  (fun f -> Ezxmlm.make_tag "hostId" ([], (String.to_xml f)))])
              @
              [Some
                 (Ezxmlm.make_tag "instanceId"
                    ([], (String.to_xml v.instance_id)))])
             @
             [Util.option_map v.tenancy
                (fun f ->
                   Ezxmlm.make_tag "tenancy" ([], (HostTenancy.to_xml f)))])
            @
            [Util.option_map v.partition_number
               (fun f ->
                  Ezxmlm.make_tag "PartitionNumber" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.host_resource_group_arn
              (fun f ->
                 Ezxmlm.make_tag "HostResourceGroupArn"
                   ([], (String.to_xml f)))])
  end
module ModifyInstancePlacementResult = ModifyInstancePlacementResult
type input = ModifyInstancePlacementRequest.t
type output = ModifyInstancePlacementResult.t
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
         ("Action", ["ModifyInstancePlacement"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyInstancePlacementRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyInstancePlacementRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyInstancePlacementResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyInstancePlacementResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyInstancePlacementResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyInstancePlacementResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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