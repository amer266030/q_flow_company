import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/model/bookmarks/bookmarked_visitor.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/supabase/client/supabase_mgr.dart';
import 'package:q_flow_company/utils/img_converter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/skills/skill.dart';
import '../model/social_links/social_link.dart';

class SupabaseCompany {
  static var supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'company';
  static const String bucketKey = "company_logo";
  static final dataMgr = GetIt.I.get<DataMgr>();

  static Future<Company?> fetchCompany() async {
    var companyId = supabase.auth.currentUser?.id;
    if (companyId != null) {
      try {
        final response = await supabase
            .from(tableKey)
            .select('*, social_link(*), bookmarked_visitor(*), skill(*)')
            .eq('id', companyId)
            .maybeSingle();

        if (response == null) return null;

        final company = Company.fromJson(response);

        dataMgr.saveCompanyData(company: company);

        if (response['social_link'] != null) {
          company.socialLinks = (response['social_link'] as List)
              .map((link) => SocialLink.fromJson(link))
              .toList();
        }

        if (response['bookmarked_visitor'] != null) {
          company.bookmarkedVisitors = (response['bookmarked_visitor'] as List?)
              ?.map((bm) => BookmarkedVisitor.fromJson(bm))
              .toList();
        }

        if (response['skill'] != null) {
          company.skills = (response['skill'] as List)
              .map((skill) => Skill.fromJson(skill))
              .toList();
        }

        return company;
      } on AuthException catch (_) {
        rethrow;
      } on PostgrestException catch (_) {
        rethrow;
      } catch (e) {
        rethrow;
      }
    } else {
      return null;
    }
  }

  static Future createCompany(
      {required Company company, required File? logoFile}) async {
    if (logoFile != null) {
      company.logoUrl = await uploadLogo(logoFile, company.name ?? '1234');
    }
    try {
      final response = await supabase
          .from(tableKey)
          .insert(company.toJson())
          .select()
          .single();
      ;
      dataMgr.saveCompanyData(company: company);

      return Company.fromJson(response);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateCompany(
      {required Company company,
      required String companyId,
      required File? imageFile}) async {
    if (imageFile != null) {
      company.logoUrl = await uploadLogo(imageFile, company.name ?? '1234');
    }
    try {
      final response = await supabase
          .from(tableKey)
          .update(company.toJson())
          .eq('id', companyId)
          .select()
          .single();
      dataMgr.saveCompanyData(company: company);
      return Company.fromJson(response);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> uploadLogo(File imageFile, String itemName) async {
    try {
      final fileBytes = await ImgConverter.fileImgToBytes(imageFile);
      final fileName = '$itemName.png';

      await supabase.storage.from(bucketKey).uploadBinary(fileName, fileBytes,
          fileOptions: const FileOptions(upsert: true));

      final publicUrl = supabase.storage.from(bucketKey).getPublicUrl(fileName);

      return publicUrl;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
