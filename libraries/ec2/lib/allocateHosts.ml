open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AllocateHostsRequest =
  struct
    type t =
      {
      auto_placement: AutoPlacement.t option
        [@ocaml.doc
          "<p>Indicates whether the host accepts any untargeted instance launches that match its instance type configuration, or if it only accepts Host tenancy instance launches that specify its unique host ID. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-dedicated-hosts-work.html#dedicated-hosts-understanding\"> Understanding Instance Placement and Host Affinity</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p> <p>Default: <code>on</code> </p>"];
      availability_zone: String.t
        [@ocaml.doc
          "<p>The Availability Zone in which to allocate the Dedicated Host.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"];
      instance_type: String.t option
        [@ocaml.doc
          "<p>Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only.</p> <p>If you want the Dedicated Hosts to support multiple instance types in a specific instance family, omit this parameter and specify <b>InstanceFamily</b> instead. You cannot specify <b>InstanceType</b> and <b>InstanceFamily</b> in the same request.</p>"];
      instance_family: String.t option
        [@ocaml.doc
          "<p>Specifies the instance family to be supported by the Dedicated Hosts. If you specify an instance family, the Dedicated Hosts support multiple instance types within that instance family.</p> <p>If you want the Dedicated Hosts to support a specific instance type only, omit this parameter and specify <b>InstanceType</b> instead. You cannot specify <b>InstanceFamily</b> and <b>InstanceType</b> in the same request.</p>"];
      quantity: Integer.t
        [@ocaml.doc
          "<p>The number of Dedicated Hosts to allocate to your account with these parameters.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>The tags to apply to the Dedicated Host during creation.</p>"];
      host_recovery: HostRecovery.t option
        [@ocaml.doc
          "<p>Indicates whether to enable or disable host recovery for the Dedicated Host. Host recovery is disabled by default. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-recovery.html\"> Host Recovery</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>Default: <code>off</code> </p>"]}
    let make ?auto_placement  ~availability_zone  ?client_token 
      ?instance_type  ?instance_family  ~quantity  ?(tag_specifications= []) 
      ?host_recovery  () =
      {
        auto_placement;
        availability_zone;
        client_token;
        instance_type;
        instance_family;
        quantity;
        tag_specifications;
        host_recovery
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.host_recovery
              (fun f ->
                 Query.Pair ("HostRecovery", (HostRecovery.to_query f)));
           Some
             (Query.Pair
                ("TagSpecification",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Some (Query.Pair ("Quantity", (Integer.to_query v.quantity)));
           Util.option_map v.instance_family
             (fun f -> Query.Pair ("InstanceFamily", (String.to_query f)));
           Util.option_map v.instance_type
             (fun f -> Query.Pair ("InstanceType", (String.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Some
             (Query.Pair
                ("AvailabilityZone", (String.to_query v.availability_zone)));
           Util.option_map v.auto_placement
             (fun f ->
                Query.Pair ("AutoPlacement", (AutoPlacement.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.host_recovery
              (fun f -> ("host_recovery", (HostRecovery.to_json f)));
           Some
             ("tag_specifications",
               (TagSpecificationList.to_json v.tag_specifications));
           Some ("quantity", (Integer.to_json v.quantity));
           Util.option_map v.instance_family
             (fun f -> ("instance_family", (String.to_json f)));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (String.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Some ("availability_zone", (String.to_json v.availability_zone));
           Util.option_map v.auto_placement
             (fun f -> ("auto_placement", (AutoPlacement.to_json f)))])
    let parse xml =
      Some
        {
          auto_placement =
            (Util.option_bind (Xml.member "autoPlacement" xml)
               AutoPlacement.parse);
          availability_zone =
            (Xml.required "availabilityZone"
               (Util.option_bind (Xml.member "availabilityZone" xml)
                  String.parse));
          client_token =
            (Util.option_bind (Xml.member "clientToken" xml) String.parse);
          instance_type =
            (Util.option_bind (Xml.member "instanceType" xml) String.parse);
          instance_family =
            (Util.option_bind (Xml.member "InstanceFamily" xml) String.parse);
          quantity =
            (Xml.required "quantity"
               (Util.option_bind (Xml.member "quantity" xml) Integer.parse));
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse));
          host_recovery =
            (Util.option_bind (Xml.member "HostRecovery" xml)
               HostRecovery.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.auto_placement
                     (fun f ->
                        Ezxmlm.make_tag "autoPlacement"
                          ([], (AutoPlacement.to_xml f)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "availabilityZone"
                       ([], (String.to_xml v.availability_zone)))])
                @
                [Util.option_map v.client_token
                   (fun f ->
                      Ezxmlm.make_tag "clientToken" ([], (String.to_xml f)))])
               @
               [Util.option_map v.instance_type
                  (fun f ->
                     Ezxmlm.make_tag "instanceType" ([], (String.to_xml f)))])
              @
              [Util.option_map v.instance_family
                 (fun f ->
                    Ezxmlm.make_tag "InstanceFamily" ([], (String.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "quantity" ([], (Integer.to_xml v.quantity)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "TagSpecification"
                       ([], (TagSpecificationList.to_xml [x]))))
               v.tag_specifications))
           @
           [Util.option_map v.host_recovery
              (fun f ->
                 Ezxmlm.make_tag "HostRecovery" ([], (HostRecovery.to_xml f)))])
  end
module AllocateHostsResult = AllocateHostsResult
type input = AllocateHostsRequest.t
type output = AllocateHostsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["AllocateHosts"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AllocateHostsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AllocateHostsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AllocateHostsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp AllocateHostsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed AllocateHostsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AllocateHostsResult - missing field in body or children: "
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