open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateSubnetRequest =
  struct
    type t =
      {
      availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone or Local Zone for the subnet.</p> <p>Default: AWS selects one for you. If you create more than one subnet in your VPC, we do not necessarily select a different zone for each subnet.</p> <p>To create a subnet in a Local Zone, set this value to the Local Zone ID, for example <code>us-west-2-lax-1a</code>. For information about the Regions that support Local Zones, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions\">Available Regions</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      availability_zone_id: String.t option
        [@ocaml.doc "<p>The AZ ID or the Local Zone ID of the subnet.</p>"];
      cidr_block: String.t
        [@ocaml.doc
          "<p>The IPv4 network range for the subnet, in CIDR notation. For example, <code>10.0.0.0/24</code>.</p>"];
      ipv6_cidr_block: String.t option
        [@ocaml.doc
          "<p>The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length.</p>"];
      outpost_arn: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) of the Outpost.</p>"];
      vpc_id: String.t [@ocaml.doc "<p>The ID of the VPC.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?availability_zone  ?availability_zone_id  ~cidr_block 
      ?ipv6_cidr_block  ?outpost_arn  ~vpc_id  ?dry_run  () =
      {
        availability_zone;
        availability_zone_id;
        cidr_block;
        ipv6_cidr_block;
        outpost_arn;
        vpc_id;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("VpcId", (String.to_query v.vpc_id)));
           Util.option_map v.outpost_arn
             (fun f -> Query.Pair ("OutpostArn", (String.to_query f)));
           Util.option_map v.ipv6_cidr_block
             (fun f -> Query.Pair ("Ipv6CidrBlock", (String.to_query f)));
           Some (Query.Pair ("CidrBlock", (String.to_query v.cidr_block)));
           Util.option_map v.availability_zone_id
             (fun f -> Query.Pair ("AvailabilityZoneId", (String.to_query f)));
           Util.option_map v.availability_zone
             (fun f -> Query.Pair ("AvailabilityZone", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("vpc_id", (String.to_json v.vpc_id));
           Util.option_map v.outpost_arn
             (fun f -> ("outpost_arn", (String.to_json f)));
           Util.option_map v.ipv6_cidr_block
             (fun f -> ("ipv6_cidr_block", (String.to_json f)));
           Some ("cidr_block", (String.to_json v.cidr_block));
           Util.option_map v.availability_zone_id
             (fun f -> ("availability_zone_id", (String.to_json f)));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)))])
    let parse xml =
      Some
        {
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          availability_zone_id =
            (Util.option_bind (Xml.member "AvailabilityZoneId" xml)
               String.parse);
          cidr_block =
            (Xml.required "CidrBlock"
               (Util.option_bind (Xml.member "CidrBlock" xml) String.parse));
          ipv6_cidr_block =
            (Util.option_bind (Xml.member "Ipv6CidrBlock" xml) String.parse);
          outpost_arn =
            (Util.option_bind (Xml.member "OutpostArn" xml) String.parse);
          vpc_id =
            (Xml.required "VpcId"
               (Util.option_bind (Xml.member "VpcId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.availability_zone
                    (fun f ->
                       Ezxmlm.make_tag "AvailabilityZone"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.availability_zone_id
                   (fun f ->
                      Ezxmlm.make_tag "AvailabilityZoneId"
                        ([], (String.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "CidrBlock"
                     ([], (String.to_xml v.cidr_block)))])
              @
              [Util.option_map v.ipv6_cidr_block
                 (fun f ->
                    Ezxmlm.make_tag "Ipv6CidrBlock" ([], (String.to_xml f)))])
             @
             [Util.option_map v.outpost_arn
                (fun f ->
                   Ezxmlm.make_tag "OutpostArn" ([], (String.to_xml f)))])
            @ [Some (Ezxmlm.make_tag "VpcId" ([], (String.to_xml v.vpc_id)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module CreateSubnetResult = CreateSubnetResult
type input = CreateSubnetRequest.t
type output = CreateSubnetResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateSubnet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateSubnetRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateSubnetRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateSubnetResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateSubnetResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateSubnetResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateSubnetResult - missing field in body or children: "
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