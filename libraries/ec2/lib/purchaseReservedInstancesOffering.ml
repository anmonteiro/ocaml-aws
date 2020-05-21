open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PurchaseReservedInstancesOfferingRequest =
  struct
    type t =
      {
      instance_count: Integer.t
        [@ocaml.doc "<p>The number of Reserved Instances to purchase.</p>"];
      reserved_instances_offering_id: String.t
        [@ocaml.doc
          "<p>The ID of the Reserved Instance offering to purchase.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      limit_price: ReservedInstanceLimitPrice.t option
        [@ocaml.doc
          "<p>Specified for Reserved Instance Marketplace offerings to limit the total order and ensure that the Reserved Instances are not purchased at unexpected prices.</p>"];
      purchase_time: DateTime.t option
        [@ocaml.doc
          "<p>The time at which to purchase the Reserved Instance, in UTC format (for example, <i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>HH</i>:<i>MM</i>:<i>SS</i>Z).</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for PurchaseReservedInstancesOffering.</p>"]
    let make ~instance_count  ~reserved_instances_offering_id  ?dry_run 
      ?limit_price  ?purchase_time  () =
      {
        instance_count;
        reserved_instances_offering_id;
        dry_run;
        limit_price;
        purchase_time
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.purchase_time
              (fun f -> Query.Pair ("PurchaseTime", (DateTime.to_query f)));
           Util.option_map v.limit_price
             (fun f ->
                Query.Pair
                  ("LimitPrice", (ReservedInstanceLimitPrice.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("ReservedInstancesOfferingId",
                  (String.to_query v.reserved_instances_offering_id)));
           Some
             (Query.Pair
                ("InstanceCount", (Integer.to_query v.instance_count)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.purchase_time
              (fun f -> ("purchase_time", (DateTime.to_json f)));
           Util.option_map v.limit_price
             (fun f ->
                ("limit_price", (ReservedInstanceLimitPrice.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("reserved_instances_offering_id",
               (String.to_json v.reserved_instances_offering_id));
           Some ("instance_count", (Integer.to_json v.instance_count))])
    let parse xml =
      Some
        {
          instance_count =
            (Xml.required "InstanceCount"
               (Util.option_bind (Xml.member "InstanceCount" xml)
                  Integer.parse));
          reserved_instances_offering_id =
            (Xml.required "ReservedInstancesOfferingId"
               (Util.option_bind
                  (Xml.member "ReservedInstancesOfferingId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          limit_price =
            (Util.option_bind (Xml.member "limitPrice" xml)
               ReservedInstanceLimitPrice.parse);
          purchase_time =
            (Util.option_bind (Xml.member "PurchaseTime" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "InstanceCount"
                     ([], (Integer.to_xml v.instance_count)))])
              @
              [Some
                 (Ezxmlm.make_tag "ReservedInstancesOfferingId"
                    ([], (String.to_xml v.reserved_instances_offering_id)))])
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.limit_price
               (fun f ->
                  Ezxmlm.make_tag "limitPrice"
                    ([], (ReservedInstanceLimitPrice.to_xml f)))])
           @
           [Util.option_map v.purchase_time
              (fun f ->
                 Ezxmlm.make_tag "PurchaseTime" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for PurchaseReservedInstancesOffering.</p>"]
module PurchaseReservedInstancesOfferingResult =
  PurchaseReservedInstancesOfferingResult
type input = PurchaseReservedInstancesOfferingRequest.t
type output = PurchaseReservedInstancesOfferingResult.t
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
         ("Action", ["PurchaseReservedInstancesOffering"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (PurchaseReservedInstancesOfferingRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (PurchaseReservedInstancesOfferingRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "PurchaseReservedInstancesOfferingResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             PurchaseReservedInstancesOfferingResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PurchaseReservedInstancesOfferingResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PurchaseReservedInstancesOfferingResult - missing field in body or children: "
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