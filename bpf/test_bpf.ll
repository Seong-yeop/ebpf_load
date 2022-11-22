; ModuleID = 'test_bpf.c'
source_filename = "test_bpf.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

@LICENSE = global [4 x i8] c"GPL\00", section "license", align 1, !dbg !0
@bpf_prog.buf = private unnamed_addr constant [14 x i8] c"Hello World!\0A\00", align 1
@llvm.used = appending global [1 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @LICENSE, i32 0, i32 0)], section "llvm.metadata"

; Function Attrs: nounwind
define i32 @bpf_prog(i8* nocapture readnone) local_unnamed_addr #0 !dbg !26 {
  %2 = alloca [14 x i8], align 1
  call void @llvm.dbg.value(metadata i8* %0, metadata !32, metadata !DIExpression()), !dbg !37
  %3 = getelementptr inbounds [14 x i8], [14 x i8]* %2, i64 0, i64 0, !dbg !38
  call void @llvm.lifetime.start.p0i8(i64 14, i8* nonnull %3) #3, !dbg !38
  call void @llvm.dbg.declare(metadata [14 x i8]* %2, metadata !33, metadata !DIExpression()), !dbg !39
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %3, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @bpf_prog.buf, i64 0, i64 0), i64 14, i32 1, i1 false), !dbg !39
  %4 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %3, i32 14) #3, !dbg !40
  call void @llvm.lifetime.end.p0i8(i64 14, i8* nonnull %3) #3, !dbg !41
  ret i32 0, !dbg !42
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!22, !23, !24}
!llvm.ident = !{!25}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "LICENSE", scope: !2, file: !3, line: 4, type: !19, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "test_bpf.c", directory: "/home/csl/yeop/test/bpf")
!4 = !{}
!5 = !{!0, !6}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !8, line: 163, type: !9, isLocal: true, isDefinition: true)
!8 = !DIFile(filename: "/usr/include/bpf/bpf_helper_defs.h", directory: "/home/csl/yeop/test/bpf")
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !13, !16, null}
!12 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !15)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !17, line: 27, baseType: !18)
!17 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "/home/csl/yeop/test/bpf")
!18 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 32, elements: !20)
!20 = !{!21}
!21 = !DISubrange(count: 4)
!22 = !{i32 2, !"Dwarf Version", i32 4}
!23 = !{i32 2, !"Debug Info Version", i32 3}
!24 = !{i32 1, !"wchar_size", i32 4}
!25 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
!26 = distinct !DISubprogram(name: "bpf_prog", scope: !3, file: !3, line: 6, type: !27, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !31)
!27 = !DISubroutineType(types: !28)
!28 = !{!29, !30}
!29 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!31 = !{!32, !33}
!32 = !DILocalVariable(name: "ctx", arg: 1, scope: !26, file: !3, line: 6, type: !30)
!33 = !DILocalVariable(name: "buf", scope: !26, file: !3, line: 7, type: !34)
!34 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 112, elements: !35)
!35 = !{!36}
!36 = !DISubrange(count: 14)
!37 = !DILocation(line: 6, column: 20, scope: !26)
!38 = !DILocation(line: 7, column: 3, scope: !26)
!39 = !DILocation(line: 7, column: 8, scope: !26)
!40 = !DILocation(line: 8, column: 3, scope: !26)
!41 = !DILocation(line: 10, column: 1, scope: !26)
!42 = !DILocation(line: 9, column: 3, scope: !26)
