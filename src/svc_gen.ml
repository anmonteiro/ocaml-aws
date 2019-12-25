(*----------------------------------------------------------------------------
 * Copyright (c) 2019, António Nuno Monteiro
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *---------------------------------------------------------------------------*)

open Ppxlib

let loc = !Ast_helper.default_loc

let (</>) a b = Filename.concat a b
let log s = Printf.eprintf (s ^^ "\n%!")

 let write_services svc_infos =
  let open Syntax in
  let type_ =
   tyvariantlet
    "t"
    (List.map
     (fun (svc_id, _, _) -> (Util.to_variant_name svc_id, []))
     svc_infos)
  in
  let to_string =
    [%stri let to_string svc =
     [%e matchvar (ident "svc") (List.map (fun (svc_id, endpoint_prefix, _) ->
       let variant_name = Util.to_variant_name svc_id in
       (variant_name, (str endpoint_prefix)))
      svc_infos)]]
  in
  let of_string =
    (* Certain differently named services use the same endpoint, so to_string /
     * of_string are not bijective. *)
    [%stri let[@ocaml.warning "-11"] of_string s =
     [%e matchstrs
           (ident "s")
           (List.map (fun (svc_id, endpoint_prefix, _) ->
             let variant_name = Util.to_variant_name svc_id in
             (endpoint_prefix, (app1 "Some" (ident variant_name))))
             svc_infos)
           (ident "None")
     ]]
  in
  let full_name =
    [%stri let full_name svc =
     [%e matchvar (ident "svc") (List.map (fun (svc_id, _, svc_name) ->
       (Util.to_variant_name svc_id, (str svc_name)))
      svc_infos)]]
  in
  let pp_hum =
    [%stri let pp_hum formatter svc = Format.fprintf formatter "%s" (full_name svc) ]
  in
  [type_; to_string; of_string; full_name; pp_hum]

let dir_contents dir =
   Sys.readdir dir
   |> Array.to_list
   |> List.filter_map (fun subdir ->
     let subdir = dir </> subdir in
     if Sys.is_directory subdir then
      Some subdir
     else
      None)

let svc_name_info dir =
  let module Json = Yojson.Basic.Util in
  (* There's an implicit contract here that we created symlinks for the latest
   * API definitions under a `latest` directory. Our `scripts/boto` script does
   * this. *)
  let input = dir </> "latest" </> "service-2.json" in
  let json = Yojson.Basic.from_file input in
  let meta = Json.member "metadata" json in
  let service_name = Json.(member "serviceFullName" meta |> to_string) in
  let service_id = match Json.(member "serviceId" meta |> to_string_option) with
   | Some id -> id
   | None -> service_name
  in
  let endpoint_prefix = Json.(member "endpointPrefix" meta |> to_string) in
  service_id, endpoint_prefix, service_name

let main input outdir =
  log "Start processing service names";
  let service_dirs =
    dir_contents input
    (* HACK(anmonteiro): sms-voice and pinpoint-sms-voice appear to be the same. *)
    |> List.filter (fun dir -> Filename.basename dir <> "sms-voice")
  in
  let svc_name_infos = List.map svc_name_info service_dirs in
  let outfile = (outdir </> "services.ml") in
  let syntax = write_services svc_name_infos in
  Util.Printing.write_structure outfile syntax;
  log "%d services processed" (List.length svc_name_infos)

module CommandLine = struct
  open Cmdliner

  let input =
    let doc = "Path to a directory where the boto service descriptions exist" in
    Arg.(required & opt (some dir) None & info ["i"; "input-dir"] ~docv:"Directory" ~doc)

  let outdir =
    let doc = "directory where generated library should be put" in
    Arg.(required & opt (some dir) None & info ["o"; "output-directory"] ~docv:"Directory" ~doc)

  let gen_t = Term.(pure main $ input $ outdir)

  let info =
    let doc = "Generate the variant type for AWS service names." in
    Term.info "svc-gen" ~version:"0.0.1" ~doc
end

(** entrypoint *)
let () =
  let open Cmdliner in
  match Term.eval CommandLine.(gen_t, info) with
  | `Error _ -> exit 1
  | _        -> exit 0
