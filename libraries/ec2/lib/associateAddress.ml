open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssociateAddressRequest =
  struct
    type t =
      {
      allocation_id: String.t option
        [@ocaml.doc
          "<p>[EC2-VPC] The allocation ID. This is required for EC2-VPC.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>The ID of the instance. This is required for EC2-Classic. For EC2-VPC, you can specify either the instance ID or the network interface ID, but not both. The operation fails if you specify an instance ID unless exactly one network interface is attached.</p>"];
      public_ip: String.t option
        [@ocaml.doc
          "<p>The Elastic IP address to associate with the instance. This is required for EC2-Classic.</p>"];
      allow_reassociation: Boolean.t option
        [@ocaml.doc
          "<p>[EC2-VPC] For a VPC in an EC2-Classic account, specify true to allow an Elastic IP address that is already associated with an instance or network interface to be reassociated with the specified instance or network interface. Otherwise, the operation fails. In a VPC in an EC2-VPC-only account, reassociation is automatic, therefore you can specify false to ensure the operation fails if the Elastic IP address is already associated with another resource.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      network_interface_id: String.t option
        [@ocaml.doc
          "<p>[EC2-VPC] The ID of the network interface. If the instance has more than one network interface, you must specify a network interface ID.</p> <p>For EC2-VPC, you can specify either the instance ID or the network interface ID, but not both. </p>"];
      private_ip_address: String.t option
        [@ocaml.doc
          "<p>[EC2-VPC] The primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address.</p>"]}
    let make ?allocation_id  ?instance_id  ?public_ip  ?allow_reassociation 
      ?dry_run  ?network_interface_id  ?private_ip_address  () =
      {
        allocation_id;
        instance_id;
        public_ip;
        allow_reassociation;
        dry_run;
        network_interface_id;
        private_ip_address
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.private_ip_address
              (fun f -> Query.Pair ("PrivateIpAddress", (String.to_query f)));
           Util.option_map v.network_interface_id
             (fun f -> Query.Pair ("NetworkInterfaceId", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.allow_reassociation
             (fun f ->
                Query.Pair ("AllowReassociation", (Boolean.to_query f)));
           Util.option_map v.public_ip
             (fun f -> Query.Pair ("PublicIp", (String.to_query f)));
           Util.option_map v.instance_id
             (fun f -> Query.Pair ("InstanceId", (String.to_query f)));
           Util.option_map v.allocation_id
             (fun f -> Query.Pair ("AllocationId", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.private_ip_address
              (fun f -> ("private_ip_address", (String.to_json f)));
           Util.option_map v.network_interface_id
             (fun f -> ("network_interface_id", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.allow_reassociation
             (fun f -> ("allow_reassociation", (Boolean.to_json f)));
           Util.option_map v.public_ip
             (fun f -> ("public_ip", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.allocation_id
             (fun f -> ("allocation_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          allocation_id =
            (Util.option_bind (Xml.member "AllocationId" xml) String.parse);
          instance_id =
            (Util.option_bind (Xml.member "InstanceId" xml) String.parse);
          public_ip =
            (Util.option_bind (Xml.member "PublicIp" xml) String.parse);
          allow_reassociation =
            (Util.option_bind (Xml.member "allowReassociation" xml)
               Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          network_interface_id =
            (Util.option_bind (Xml.member "networkInterfaceId" xml)
               String.parse);
          private_ip_address =
            (Util.option_bind (Xml.member "privateIpAddress" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.allocation_id
                    (fun f ->
                       Ezxmlm.make_tag "AllocationId" ([], (String.to_xml f)))])
                @
                [Util.option_map v.instance_id
                   (fun f ->
                      Ezxmlm.make_tag "InstanceId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.public_ip
                  (fun f ->
                     Ezxmlm.make_tag "PublicIp" ([], (String.to_xml f)))])
              @
              [Util.option_map v.allow_reassociation
                 (fun f ->
                    Ezxmlm.make_tag "allowReassociation"
                      ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.network_interface_id
               (fun f ->
                  Ezxmlm.make_tag "networkInterfaceId"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.private_ip_address
              (fun f ->
                 Ezxmlm.make_tag "privateIpAddress" ([], (String.to_xml f)))])
  end
module AssociateAddressResult = AssociateAddressResult
type input = AssociateAddressRequest.t
type output = AssociateAddressResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["AssociateAddress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssociateAddressRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AssociateAddressRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AssociateAddressResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp AssociateAddressResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed AssociateAddressResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AssociateAddressResult - missing field in body or children: "
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