
# 单元测试
你将作为仓库内的自动化开发助理，针对当前分支相对 master 的变更，补充/修改单元测试，直到编译与测试通过，且“变更行覆盖率”≥70%。严格遵循以下约束与步骤执行。

## 任务目标
   - 为有业务逻辑改动的类补充/修改单测。
   - 新增+修改的代码行覆盖率 ≥ 70%（分母=变更的总行数；分子=被单测覆盖的变更行数）。
   - 所有代码成功编译；所有单测运行通过。
   - 不修改生产代码与 pom.xml。
   - 将新增/修改的测试文件加入暂存区（git add）。
## 约束要求（务必遵守）
   - 不要修改被测代码（src/main/java 下的生产代码）。
   - 不要修改 pom.xml（单测依赖通过现有传递性依赖解决）。
   - 仅在 src/test/java 下新增/修改测试代码及必要测试资源。
   - 不需为以下类型补充/生成单测：
      - 仅包含 getter/setter/is 的简单类（如 DO/DTO/Entity/Entry/Model/VO/Request/Response 等，或仅有 Lombok @Getter/@Setter/@Data 且无自定义逻辑）。
      - 枚举类（enum）。
   - 禁止依赖真实外部资源（网络、DB、文件系统等）；需要时使用 mock/fake/stub。
   - 测试框架JUnit4 Mockito
   - 不使用 @SpringBootTest 等重型集成测试, 使用@RunWith(MockitoJUnitRunner.Silent.class)
## 执行步骤
### 对比 master 识别改动类文件
   - 同步远端并比对当前分支与 master 的共同祖先：
      - git fetch origin
      - git diff --name-status origin/master...HEAD -- '*.java'
   - 记录 src/main/java 下新增(A)/修改(M)/重命名(R)的 Java 类文件清单。
### 过滤无需补测的类
   - 排除：
      - 仅含字段与 getter/setter/is 的 POJO。
      - 枚举类（enum）。
      - 明显数据承载路径且无业务逻辑的类（如 model/do/dto/entity/vo/request/response/entry 等）。
   - 得到“需要补测/改测”的目标类清单。
### 检查是否已有对应测试类
   - 对每个目标类 X（如 com.example.Foo）：
      - 在 src/test/java 下同包路径查找 FooTest/FooTests/FooUT 等命名。
      - 若存在：在原测试基础上新增/修改用例以覆盖本次改动逻辑。
      - 若不存在：新建完整测试类，包含正确 package/import、规范命名（ClassNameTest）、初始化/清理方法与清晰的 Arrange-Act-Assert 结构。
### 编写/修改测试用例（聚焦变更）
   - 覆盖新增/修改行涉及的关键逻辑：
      - 分支与条件
      - 异常路径
      - 边界值与空/非法输入
   - 每个测试方法聚焦一个行为/分支，减少耦合与不稳定因素。
   - 不使用真实 IO/网络/DB；对时间/随机/单例等引入可控替代或 mock。
   - 对工具类/静态方法，优先通过公开 API 驱动覆盖。
### 运行测试并生成覆盖率报告（不改 pom）

### 计算“变更行覆盖率”并校验阈值（≥70%）,若覆盖率 < 70%，回到步骤 "编写/修改测试用例" 继续补测，直至达标
### 最终检查（全部必须通过）
   - 变更行覆盖率 ≥ 70%
   - 未修改任何生产代码与 pom.xml（不要修改被测代码）
### 暂存新增与修改的文件
   - git add src/test/java
## 输出与交付
   - 在控制台打印最终摘要，包含：
      - 需要补测/改测的目标类清单
      - 新增的测试类文件路径
      - 修改的测试类文件路径
      - 关键用例点（覆盖的分支/异常/边界）
      - “变更行覆盖率”各文件明细与总体结果
      - 编译与测试结果（通过/失败）
