open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeReservedInstancesModificationsRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>client-token</code> - The idempotency token for the modification request.</p> </li> <li> <p> <code>create-date</code> - The time when the modification request was created.</p> </li> <li> <p> <code>effective-date</code> - The time when the modification becomes effective.</p> </li> <li> <p> <code>modification-result.reserved-instances-id</code> - The ID for the Reserved Instances created as part of the modification request. This ID is only available when the status of the modification is <code>fulfilled</code>.</p> </li> <li> <p> <code>modification-result.target-configuration.availability-zone</code> - The Availability Zone for the new Reserved Instances.</p> </li> <li> <p> <code>modification-result.target-configuration.instance-count </code> - The number of new Reserved Instances.</p> </li> <li> <p> <code>modification-result.target-configuration.instance-type</code> - The instance type of the new Reserved Instances.</p> </li> <li> <p> <code>modification-result.target-configuration.platform</code> - The network platform of the new Reserved Instances (<code>EC2-Classic</code> | <code>EC2-VPC</code>).</p> </li> <li> <p> <code>reserved-instances-id</code> - The ID of the Reserved Instances modified.</p> </li> <li> <p> <code>reserved-instances-modification-id</code> - The ID of the modification request.</p> </li> <li> <p> <code>status</code> - The status of the Reserved Instances modification request (<code>processing</code> | <code>fulfilled</code> | <code>failed</code>).</p> </li> <li> <p> <code>status-message</code> - The reason for the status.</p> </li> <li> <p> <code>update-date</code> - The time when the modification request was last updated.</p> </li> </ul>"];
      reserved_instances_modification_ids:
        ReservedInstancesModificationIdStringList.t
        [@ocaml.doc "<p>IDs for the submitted modification request.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to retrieve the next page of results.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DescribeReservedInstancesModifications.</p>"]
    let make ?(filters= [])  ?(reserved_instances_modification_ids= []) 
      ?next_token  () =
      { filters; reserved_instances_modification_ids; next_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Some
             (Query.Pair
                ("ReservedInstancesModificationId",
                  (ReservedInstancesModificationIdStringList.to_query
                     v.reserved_instances_modification_ids)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("reserved_instances_modification_ids",
               (ReservedInstancesModificationIdStringList.to_json
                  v.reserved_instances_modification_ids));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          reserved_instances_modification_ids =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ReservedInstancesModificationId" xml)
                  ReservedInstancesModificationIdStringList.parse));
          next_token =
            (Util.option_bind (Xml.member "nextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ReservedInstancesModificationId"
                       ([],
                         (ReservedInstancesModificationIdStringList.to_xml
                            [x])))) v.reserved_instances_modification_ids))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "nextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeReservedInstancesModifications.</p>"]
module DescribeReservedInstancesModificationsResult =
  DescribeReservedInstancesModificationsResult
type input = DescribeReservedInstancesModificationsRequest.t
type output = DescribeReservedInstancesModificationsResult.t
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
         ("Action", ["DescribeReservedInstancesModifications"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeReservedInstancesModificationsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (DescribeReservedInstancesModificationsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "DescribeReservedInstancesModificationsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             DescribeReservedInstancesModificationsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeReservedInstancesModificationsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeReservedInstancesModificationsResult - missing field in body or children: "
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