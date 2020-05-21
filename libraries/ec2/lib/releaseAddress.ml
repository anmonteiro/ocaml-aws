open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ReleaseAddressRequest =
  struct
    type t =
      {
      allocation_id: String.t option
        [@ocaml.doc
          "<p>[EC2-VPC] The allocation ID. Required for EC2-VPC.</p>"];
      public_ip: String.t option
        [@ocaml.doc
          "<p>[EC2-Classic] The Elastic IP address. Required for EC2-Classic.</p>"];
      network_border_group: String.t option
        [@ocaml.doc
          "<p>The location that the IP address is released from.</p> <p>If you provide an incorrect network border group, you will receive an <code>InvalidAddress.NotFound</code> error. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html\">Error Codes</a>.</p> <note> <p>You cannot use a network border group with EC2 Classic. If you attempt this operation on EC2 classic, you will receive an <code>InvalidParameterCombination</code> error. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html\">Error Codes</a>.</p> </note>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?allocation_id  ?public_ip  ?network_border_group  ?dry_run  ()
      = { allocation_id; public_ip; network_border_group; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.network_border_group
             (fun f -> Query.Pair ("NetworkBorderGroup", (String.to_query f)));
           Util.option_map v.public_ip
             (fun f -> Query.Pair ("PublicIp", (String.to_query f)));
           Util.option_map v.allocation_id
             (fun f -> Query.Pair ("AllocationId", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.network_border_group
             (fun f -> ("network_border_group", (String.to_json f)));
           Util.option_map v.public_ip
             (fun f -> ("public_ip", (String.to_json f)));
           Util.option_map v.allocation_id
             (fun f -> ("allocation_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          allocation_id =
            (Util.option_bind (Xml.member "AllocationId" xml) String.parse);
          public_ip =
            (Util.option_bind (Xml.member "PublicIp" xml) String.parse);
          network_border_group =
            (Util.option_bind (Xml.member "NetworkBorderGroup" xml)
               String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.allocation_id
                 (fun f ->
                    Ezxmlm.make_tag "AllocationId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.public_ip
                (fun f -> Ezxmlm.make_tag "PublicIp" ([], (String.to_xml f)))])
            @
            [Util.option_map v.network_border_group
               (fun f ->
                  Ezxmlm.make_tag "NetworkBorderGroup"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = ReleaseAddressRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["ReleaseAddress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ReleaseAddressRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ReleaseAddressRequest.to_headers req)), "")
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