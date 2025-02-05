# `CODEOWNERS` - Defining Code Review Responsibility

## **📌 Purpose**
The `CODEOWNERS` file assigns **default reviewers** for pull requests by specifying **who is responsible for different parts of the repository**.  
This ensures:
- **Automatic code review assignments** based on ownership.
- **Consistent responsibility** over critical files.
- **Clear team-based accountability** in large projects.

📖 **Official Docs:**  
- [GitHub CODEOWNERS Guide](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)  
- [GitHub CODEOWNERS Best Practices](https://github.blog/2018-06-20-what-are-code-owners/)  

---

## **🛠 Key Features**
### **1️⃣ Assigning a Global Owner**
Defines a **default owner for all files**:  
```
* @szmyty
```  

### **2️⃣ Assigning Teams (Optional)**
Defines **team-based responsibility** for sections of the codebase:  
```
# frontend/ @myorg/frontend-team
# backend/ @myorg/backend-team
# infra/ @myorg/devops-team
```  

### **3️⃣ Protecting Sensitive Files**
Ensures only **authorized users or teams** can modify security-related files:  
```
SECURITY.md @myorg/security-team
CODEOWNERS @myorg/admins
```  

### **4️⃣ Defining Fallback Reviewers**
If no match is found, assigns **a default review team**:  
```
* @myorg/core-maintainers
```  

---

## **🛠 How to Use**
1. **Place `CODEOWNERS` inside the `.github/` directory.**  
2. **To check ownership assignments**, create a PR and view the default reviewers.  
3. **If using GitHub teams, define them inside your organization first.**  

---

## **✅ Best Practices**
✔ Use **teams instead of individuals** where possible.  
✔ Assign **different teams to different code areas**.  
✔ Regularly **update the file** as teams change.  
✔ **Protect sensitive files** by restricting who owns them.  

---

🔗 **Related Resources:**  
- [GitHub CODEOWNERS Guide](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)  
- [Using GitHub Teams for CODEOWNERS](https://docs.github.com/en/organizations/collaborating-with-groups-in-your-organization/setting-up-and-managing-teams)  

---
