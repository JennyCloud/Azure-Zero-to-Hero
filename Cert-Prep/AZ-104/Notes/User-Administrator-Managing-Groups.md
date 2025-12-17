# User Administrator Permissions for Managing Groups in Microsoft Entra ID

## ⭐ Correct Rule
A **User Administrator** can manage membership of **any group they do not own**,  
**as long as the group is NOT a role-assignable group.**

This includes:

- ✔ Assigned security groups  
- ✔ Dynamic security groups  
- ✔ Microsoft 365 groups  

But **not**:

- ❌ Role-assignable groups (special privileged groups)

---

## 🌱 Why User Administrators Can Manage Non-Role-Assignable Groups
The **User Administrator** role has directory-level permissions to:

- Add/remove **users** to groups  
- Add/remove **devices** to groups  
- Modify membership for non-role-assignable groups  
- Manage group properties (with some limitations)

Group **ownership is not required** for these actions.

This is why a User Administrator can manage membership for groups they do not own.

---

## 🌳 Why Role-Assignable Groups Are Restricted
Role-assignable groups can themselves be granted **Azure RBAC roles**, meaning group membership can:

- Grant privileged access  
- Escalate permissions  
- Impact critical governance

For security reasons, only:

- **Global Administrators**, or  
- **Privileged Role Administrators**

can modify these groups.

User Administrators are **blocked** from managing them.

---

## 🌼 Clean Mental Model
- **User Administrator** → Can manage any group except role-assignable groups  
- **Group Owner** → Can always manage their own group  
- **Cloud Device Administrator** → Manages device objects, **not** group membership  
- **Role-Assignabe Groups** → Restricted to higher privilege roles  

---

## ⭐ Final Summary
A **User Administrator** *can manage groups they do not own*,  
**unless the group is role-assignable** — in which case only highly privileged roles can modify it.
