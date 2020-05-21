open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssociateDhcpOptionsRequest =
  struct
    type t =
      {
      dhcp_options_id: String.t
        [@ocaml.doc
          "<p>The ID of the DHCP options set, or <code>default</code> to associate no DHCP options with the VPC.</p>"];
      vpc_id: String.t [@ocaml.doc "<p>The ID of the VPC.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~dhcp_options_id  ~vpc_id  ?dry_run  () =
      { dhcp_options_id; vpc_id; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("VpcId", (String.to_query v.vpc_id)));
           Some
             (Query.Pair
                ("DhcpOptionsId", (String.to_query v.dhcp_options_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("vpc_id", (String.to_json v.vpc_id));
           Some ("dhcp_options_id", (String.to_json v.dhcp_options_id))])
    let parse xml =
      Some
        {
          dhcp_options_id =
            (Xml.required "DhcpOptionsId"
               (Util.option_bind (Xml.member "DhcpOptionsId" xml)
                  String.parse));
          vpc_id =
            (Xml.required "VpcId"
               (Util.option_bind (Xml.member "VpcId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DhcpOptionsId"
                   ([], (String.to_xml v.dhcp_options_id)))])
            @ [Some (Ezxmlm.make_tag "VpcId" ([], (String.to_xml v.vpc_id)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = AssociateDhcpOptionsRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["AssociateDhcpOptions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssociateDhcpOptionsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AssociateDhcpOptionsRequest.to_headers req)),
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