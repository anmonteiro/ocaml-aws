open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribePlacementGroupsRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>group-name</code> - The name of the placement group.</p> </li> <li> <p> <code>state</code> - The state of the placement group (<code>pending</code> | <code>available</code> | <code>deleting</code> | <code>deleted</code>).</p> </li> <li> <p> <code>strategy</code> - The strategy of the placement group (<code>cluster</code> | <code>spread</code> | <code>partition</code>).</p> </li> </ul>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      group_names: PlacementGroupStringList.t
        [@ocaml.doc
          "<p>The names of the placement groups.</p> <p>Default: Describes all your placement groups, or only those otherwise specified.</p>"];
      group_ids: PlacementGroupIdStringList.t
        [@ocaml.doc "<p>The IDs of the placement groups.</p>"]}
    let make ?(filters= [])  ?dry_run  ?(group_names= [])  ?(group_ids= []) 
      () = { filters; dry_run; group_names; group_ids }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("GroupId",
                   (PlacementGroupIdStringList.to_query v.group_ids)));
           Some
             (Query.Pair
                ("GroupName",
                  (PlacementGroupStringList.to_query v.group_names)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("group_ids", (PlacementGroupIdStringList.to_json v.group_ids));
           Some
             ("group_names",
               (PlacementGroupStringList.to_json v.group_names));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          group_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "groupName" xml)
                  PlacementGroupStringList.parse));
          group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "GroupId" xml)
                  PlacementGroupIdStringList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filters))
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "groupName"
                       ([], (PlacementGroupStringList.to_xml [x]))))
               v.group_names))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "GroupId"
                      ([], (PlacementGroupIdStringList.to_xml [x]))))
              v.group_ids))
  end
module DescribePlacementGroupsResult = DescribePlacementGroupsResult
type input = DescribePlacementGroupsRequest.t
type output = DescribePlacementGroupsResult.t
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
         ("Action", ["DescribePlacementGroups"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribePlacementGroupsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribePlacementGroupsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribePlacementGroupsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribePlacementGroupsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribePlacementGroupsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribePlacementGroupsResult - missing field in body or children: "
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