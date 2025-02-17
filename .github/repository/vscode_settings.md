# `.vscode/settings.json` - VSCode Workspace Configuration  

## **📌 Purpose**  
This file **configures VSCode workspace settings** to ensure:  
✔ Consistent **formatting, linting, and editor behavior**.  
✔ Better **developer experience (DX)** across all contributors.  
✔ Optimized **search, TypeScript, and dependency management**.  

📖 **Official Docs:**  
- [VSCode Workspace Settings](https://code.visualstudio.com/docs/getstarted/settings)  
- [Prettier Extension](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)  
- [ESLint Extension](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)  

---

## **🛠 Key Features**
### **1️⃣ Search Optimization**
- **Excludes unnecessary files** from search results.  
**code snippet**  
"search.exclude": {  
    "/public/locales/**": true, // Ignore translation files  
    "pnpm-lock.yaml": true // Avoid polluting search results with lockfile content  
}  
**end snippet**  

### **2️⃣ Auto-Formatting & Prettier Integration**
- **Ensures code is formatted correctly on save.**  
**code snippet**  
"editor.formatOnSave": true,  
"editor.defaultFormatter": "esbenp.prettier-vscode",  
"prettier.printWidth": 100,  
"prettier.singleQuote": true,  
"prettier.trailingComma": "es5"  
**end snippet**  

### **3️⃣ ESLint & TypeScript Setup**
- **Uses pnpm as the package manager** and validates JavaScript & TypeScript files.  
**code snippet**  
"eslint.packageManager": "pnpm",  
"eslint.validate": ["javascript", "typescript", "typescriptreact", "json"],  
"typescript.tsdk": "node_modules/typescript/lib"  
**end snippet**  

### **4️⃣ Auto-Save & Trust Settings**
- **Automatically saves files on focus change** to reduce data loss.  
**code snippet**  
"files.autoSave": "onFocusChange"  
**end snippet**  

---

## **🛠 How to Use**
1. **Ensure `.vscode/settings.json` is committed to the repo** so all contributors get the same setup.  
2. **Customize as needed** for project-specific requirements.  
3. **Keep it updated** as the project evolves.  

---

## **✅ Best Practices**
✔ Keep settings **minimal but effective** to avoid clutter.  
✔ Use **`.editorconfig` + `settings.json`** together for consistent formatting.  
✔ Encourage **contributors to install recommended extensions** (Prettier, ESLint).  

---

🔗 **Related Resources:**  
- [VSCode Best Practices](https://code.visualstudio.com/docs/editor/codebasics)  
- [Improving DX with EditorConfig](https://editorconfig.org/)  

---
